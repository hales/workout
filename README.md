# The Long Season

Family accountability tracker. Oct 1 2026 – Apr 18 2027, 200 days.

## Deploy

1. Push this folder to a repo.
2. Settings → Pages → Source: **Deploy from a branch**, branch `main`, folder `/ (root)`.
3. Open the Pages URL. It works immediately, saving to **that device only**.

## Share data across the family

Without this step every phone keeps its own separate copy.

1. Create a Supabase project.
2. SQL Editor → paste and run `supabase.sql`.
3. Project Settings → API → copy the **Project URL** and the **anon** key.
4. Open `index.html`, find the block near the top, fill in:

   ```js
   var SUPABASE_URL  = "https://xxxxx.supabase.co";
   var SUPABASE_ANON = "eyJ...";
   ```

5. Commit and push. The banner about device-only saving disappears.

## What's stored

| Key | Contents |
|---|---|
| `fc:roster` | Members, goals, habits, colours, starting weights |
| `fc:log:<id>` | One member's daily ticks and weight entries |
| `fc:routine` | The workout sequence |
| `fc:mig` | Schema version marker |

## Know before you deploy

**The anon key is public.** It ships in the page source — that's how it works.
Combined with the policy in `supabase.sql`, anyone who finds the URL can read
and write everything, including weights. For a family tracker on an
unadvertised URL that's usually an acceptable trade, but it is a trade. If you
want it locked down, switch to Supabase password auth and change the policy
from `to anon` to `to authenticated`.

**Data refreshes when you focus the tab**, not continuously. Two people ticking
at the same moment: last write wins for that member's log. Since each person
has their own key, this only bites if two people edit the *same* member.
