# ☁️ Synchro multi-admin avec Supabase

Une base de données gratuite partagée : toutes les modifications du dashboard
(runners, feuilles, factures, paramètres) sont visibles par tous les admins,
en temps réel.

## Étape 1 — Utiliser ton projet existant

Pas besoin d'un nouveau projet : on ajoute simplement une table dédiée
(`oilroxwood_etat`) dans ton projet Supabase actuel. Elle n'interfère pas
avec tes autres tables.

## Étape 2 — Créer la table

Ouvre ton projet → **SQL Editor** → **New query** → colle ce bloc → **Run** :

```sql
create table if not exists oilroxwood_etat (
  id int primary key,
  data jsonb not null,
  maj timestamptz default now()
);

alter table oilroxwood_etat enable row level security;

create policy "acces_dashboard_oilroxwood" on oilroxwood_etat
  for all using (true) with check (true);

alter publication supabase_realtime add table oilroxwood_etat;
```

## Étape 3 — Récupérer les clés

Menu **Settings → API** (ou Project Settings → Data API) :

- **Project URL** — ressemble à `https://xxxxxxxx.supabase.co`
- **anon public** key — longue chaîne commençant par `eyJ…`

## Étape 4 — Me donner les deux valeurs

Colle-les moi dans le chat : j'insère les deux constantes dans `admin.html`
(`SB_URL` et `SB_KEY` tout en haut du script) et on pousse.

⚠️ La clé « anon public » est conçue pour être visible côté client, c'est normal.
Par contre ne partage JAMAIS la clé « service_role ».

## Comment ça marche ensuite

- À la connexion au dashboard, l'état est chargé depuis Supabase
- Chaque modification est envoyée automatiquement (~1 s après)
- Les autres admins connectés voient la mise à jour instantanément
- La pastille à côté du logo dans la barre latérale indique l'état de la synchro
  (vert = connecté, rouge = problème, gris = non configuré)
- En cas de modifications simultanées, la dernière sauvegarde gagne
