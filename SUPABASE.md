# Turning on Login + Progress Sync (Supabase)

The app works with no login by default. Follow these one-time steps to switch on
accounts, the login gate, cloud progress sync, and the leader dashboard. No
coding required — you'll copy two keys and paste one SQL script.

Total time: ~15 minutes.

---

## 1. Create a free Supabase project

1. Go to **https://supabase.com** → sign up (free) → **New project**.
2. Name it (e.g. `dwc-podcast`), set a database password (save it somewhere),
   pick the closest region, and create. Wait ~2 minutes for it to provision.

## 2. Run the database script

1. In your project, open **SQL Editor → New query**.
2. Open the file **`supabase-setup.sql`** (in this repo), copy everything, paste
   it in, and click **Run**. You should see "Success".

This creates the tables, security rules, and the auto-signup trigger.

## 3. Get your two keys

1. Go to **Project Settings → API**.
2. Copy the **Project URL** (looks like `https://abcd1234.supabase.co`).
3. Copy the **anon public** key (a long string). *Do not use the `service_role`
   key — the anon key is the safe one to put in the app.*

## 4. Paste the keys into the app

1. Open `index.html` and find this block (near the bottom, in the script):

   ```js
   var SUPABASE_URL      = "";     // e.g. https://abcd1234.supabase.co
   var SUPABASE_ANON_KEY = "";     // the long "anon public" key
   var ENABLE_GOOGLE     = false;  // set true AFTER enabling Google in Supabase
   ```

2. Paste your Project URL and anon key between the quotes. Save.
3. Commit and push (`git add -A && git commit -m "Enable login" && git push`).
   Vercel redeploys automatically; the login screen now appears.

## 5. Set up sign-in

**Email magic link** works out of the box — nothing to configure. Volunteers
enter their email and click the link Supabase sends them.

**Add the live site as a redirect URL** so links land back on your app:
- **Authentication → URL Configuration**
- Set **Site URL** to your Vercel URL (e.g. `https://dwc-podcast-ministry.vercel.app`)
- Add the same URL under **Redirect URLs**.

**Optional — Google sign-in:**
- **Authentication → Providers → Google → Enable**, follow Supabase's prompts to
  add Google OAuth credentials, then set `ENABLE_GOOGLE = true` in `index.html`.

## 6. Make yourself a leader

1. Open the live app and sign in once (so your account is created).
2. In Supabase **SQL Editor**, run (with your email):

   ```sql
   update public.app_roles set role = 'leader'
   where user_id = (select id from auth.users where email = 'you@example.com');
   ```

3. Refresh the app — a **Leaders** tab appears with everyone's progress.

---

## How it works / good to know

- **Progress sync:** each person's lessons, checklists, and quiz save to their
  account and follow them across phone, tablet, and computer.
- **Privacy:** Row-Level Security means volunteers can only read/write their own
  progress; only leaders can see everyone's.
- **The anon key is safe in the browser** — it only allows what the security
  rules permit. Never put the `service_role` key in the app.
- **Content note:** the login screen restricts the *experience*, and the
  database is fully protected, but the training text itself is still in the page
  source. For training material that's fine. If you need to hide the content
  itself from non-members, add **Vercel Password Protection** (Project →
  Settings → Deployment Protection) as an extra layer.
- **Offline:** with login on, the first load needs internet to sign in; after
  that, progress still saves locally and syncs up when back online.
