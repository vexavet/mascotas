-- Ejecuta este script en Supabase: SQL Editor > New query > Run

create table if not exists public.mascotas (
  id               uuid primary key default gen_random_uuid(),
  nombre           text not null,
  especie          text not null default 'Perro',
  raza             text,
  sexo             text,
  fecha_nacimiento date,
  peso_kg          numeric(5,2),
  color            text,
  microchip        text,
  esterilizado     boolean not null default false,
  vacunas_al_dia   boolean not null default false,
  alergias         text,
  duenio_nombre    text,
  duenio_telefono  text,
  notas            text,
  creado_en        timestamptz not null default now(),
  actualizado_en   timestamptz not null default now()
);

-- Actualiza automáticamente la fecha de modificación
create or replace function public.set_actualizado_en()
returns trigger language plpgsql as $$
begin
  new.actualizado_en = now();
  return new;
end $$;

drop trigger if exists trg_mascotas_actualizado on public.mascotas;
create trigger trg_mascotas_actualizado
before update on public.mascotas
for each row execute function public.set_actualizado_en();

-- Seguridad a nivel de fila (obligatorio en Supabase)
alter table public.mascotas enable row level security;

-- ⚠️ DEMO: permite que cualquiera con la página lea y modifique datos.
-- Para producción, reemplaza "anon" por "authenticated" y agrega login.
drop policy if exists "demo_select" on public.mascotas;
drop policy if exists "demo_insert" on public.mascotas;
drop policy if exists "demo_update" on public.mascotas;
drop policy if exists "demo_delete" on public.mascotas;

create policy "demo_select" on public.mascotas for select to anon using (true);
create policy "demo_insert" on public.mascotas for insert to anon with check (true);
create policy "demo_update" on public.mascotas for update to anon using (true) with check (true);
create policy "demo_delete" on public.mascotas for delete to anon using (true);

-- Dato de ejemplo
insert into public.mascotas (nombre, especie, raza, sexo, fecha_nacimiento, peso_kg, color, esterilizado, vacunas_al_dia, duenio_nombre, duenio_telefono)
values ('Luna', 'Perro', 'Labrador', 'Hembra', '2021-03-14', 24.5, 'Dorado', true, true, 'María Pérez', '0991234567');
