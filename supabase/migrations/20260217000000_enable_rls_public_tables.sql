-- Enable Row Level Security on all public tables
--
-- The backend API uses the service_role key which bypasses RLS,
-- so existing API functionality is unaffected. This migration
-- prevents unauthorized direct access via the anon key / PostgREST.

alter table public.projects enable row level security;
alter table public.monitors enable row level security;
alter table public.events enable row level security;
alter table public.event_stats enable row level security;
alter table public.incidents enable row level security;
alter table public.provider_status enable row level security;
alter table public.notification_channels enable row level security;
alter table public.notification_log enable row level security;
alter table public.waitlist enable row level security;
alter table public.webhook_events enable row level security;

-- With RLS enabled and no policies defined, all access via the anon
-- and authenticated roles is denied by default. The service_role key
-- (used by the backend API) bypasses RLS entirely.
--
-- If you later need direct client-side Supabase access for specific
-- tables, add explicit policies. For example:
--
--   create policy "Users can read own projects"
--     on public.projects for select
--     using (auth.uid() = user_id);
