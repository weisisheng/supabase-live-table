create table "public"."thing" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "name" text not null,
    "type" text not null
);

alter table "public"."thing" enable row level security;

CREATE UNIQUE INDEX thing_id_key ON public.thing USING btree (id);

CREATE UNIQUE INDEX thing_pkey ON public.thing USING btree (id);

alter table "public"."thing" add constraint "thing_pkey" PRIMARY KEY using index "thing_pkey";

alter table "public"."thing" add constraint "thing_id_key" UNIQUE using index "thing_id_key";

create policy "Enable read access for all users"
on "public"."thing"
as permissive
for select
to public
using (true);

drop publication if exists supabase_realtime;
create publication supabase_realtime;
alter publication supabase_realtime add table "thing";

