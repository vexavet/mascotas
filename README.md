# Ficha de mascotas (CRUD + PostgreSQL + GitHub Pages)

Página estática responsiva alojada en **GitHub Pages**, con datos guardados en **PostgreSQL** (Supabase).

## 1. Base de datos (Supabase, gratis)
1. Crea una cuenta en https://supabase.com y un **New project**.
2. Ve a **SQL Editor → New query**, pega el contenido de `schema.sql` y pulsa **Run**.
3. Ve a **Project Settings → API** y copia:
   - **Project URL**
   - **anon public key**
4. Abre `index.html` y reemplaza `SUPABASE_URL` y `SUPABASE_ANON_KEY` (están al inicio del `<script>`).

## 2. Subir a GitHub
```bash
git init
git add index.html schema.sql README.md
git commit -m "Ficha de mascotas"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/mascotas.git
git push -u origin main
```
(Antes crea el repositorio vacío `mascotas` en https://github.com/new)

## 3. Publicar con GitHub Pages
1. En el repositorio: **Settings → Pages**.
2. En **Build and deployment → Source** elige **Deploy from a branch**.
3. Branch: `main`, carpeta `/ (root)` → **Save**.
4. En 1–2 minutos estará en `https://TU_USUARIO.github.io/mascotas/`.

## Seguridad
La clave `anon` es pública por diseño; la protección real son las políticas RLS de `schema.sql`.
Las políticas incluidas son de **demo** (cualquiera con el link puede leer y editar).
Para uso real, agrega Supabase Auth y cambia las políticas de `anon` a `authenticated`.
