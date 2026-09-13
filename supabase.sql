-- Run this once in the Supabase SQL editor.

create table if not exists public.kv (
  key         text primary key,
  value       text not null,
  updated_at  timestamptz not null default now()
);

alter table public.kv enable row level security;

-- Anyone holding the anon key can read and write. See the README:
-- this is deliberate, and it is the trade-off to understand before deploying.
drop policy if exists kv_all on public.kv;
create policy kv_all on public.kv
  for all
  to anon
  using (true)
  with check (true);

-- RLS governs rows; these grant table access to the role itself.
-- Missing grants are the usual cause of a silent 401/403 on save.
grant usage on schema public to anon;
grant select, insert, update, delete on public.kv to anon;
