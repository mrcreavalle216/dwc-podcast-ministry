-- ============================================================
-- Dominion World Center — Podcast Ministry Training App
-- Supabase database setup
-- Run this ONCE in the Supabase SQL Editor (Dashboard → SQL → New query).
-- ============================================================

-- 1) PROFILE + PROGRESS TABLE -------------------------------------------------
-- One row per signed-in volunteer. Holds their training progress as JSON
-- (the same shape the app stores locally: learn / checks / quiz).
create table if not exists public.profiles (
  id          uuid primary key references auth.users (id) on delete cascade,
  email       text,
  full_name   text,
  learn       jsonb not null default '{}'::jsonb,
  checks      jsonb not null default '{}'::jsonb,
  quiz        jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- 2) ROLES TABLE --------------------------------------------------------------
-- Kept separate from profiles so the "leaders can see everyone" rule does not
-- recurse on the profiles table. Default role is 'volunteer'.
create table if not exists public.app_roles (
  user_id uuid primary key references auth.users (id) on delete cascade,
  role    text not null default 'volunteer'
);

-- 3) LEADER CHECK (security definer avoids RLS recursion) ----------------------
create or replace function public.is_leader()
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.app_roles
    where user_id = auth.uid() and role = 'leader'
  );
$$;

-- 4) AUTO-CREATE PROFILE + ROLE ON SIGNUP ------------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email)
    values (new.id, new.email)
    on conflict (id) do nothing;
  insert into public.app_roles (user_id, role)
    values (new.id, 'volunteer')
    on conflict (user_id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- 5) ROW LEVEL SECURITY -------------------------------------------------------
alter table public.profiles  enable row level security;
alter table public.app_roles enable row level security;

-- profiles: a user can see/insert/update their OWN row; leaders can read ALL.
drop policy if exists "own profile read"   on public.profiles;
drop policy if exists "leader read all"    on public.profiles;
drop policy if exists "own profile insert" on public.profiles;
drop policy if exists "own profile update" on public.profiles;

create policy "own profile read"   on public.profiles
  for select using (auth.uid() = id);
create policy "leader read all"    on public.profiles
  for select using (public.is_leader());
create policy "own profile insert" on public.profiles
  for insert with check (auth.uid() = id);
create policy "own profile update" on public.profiles
  for update using (auth.uid() = id) with check (auth.uid() = id);

-- app_roles: a user can read their OWN role; leaders can read all.
drop policy if exists "own role read"    on public.app_roles;
drop policy if exists "leader role read" on public.app_roles;

create policy "own role read"    on public.app_roles
  for select using (auth.uid() = user_id);
create policy "leader role read" on public.app_roles
  for select using (public.is_leader());

-- ============================================================
-- 6) MAKE YOURSELF A LEADER
-- After you have signed in to the app at least once (so your account exists),
-- run this with YOUR email to unlock the leader dashboard:
--
--   update public.app_roles set role = 'leader'
--   where user_id = (select id from auth.users where email = 'you@example.com');
--
-- ============================================================
