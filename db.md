## Table `utilisateurs`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_utilisateur` | `uuid` | Primary |
| `nom` | `text` |  |
| `prenom` | `text` |  |
| `role` | `text` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `zones`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_zone` | `uuid` | Primary |
| `nom` | `text` |  |
| `description` | `text` |  Nullable |
| `created_at` | `timestamptz` |  Nullable |

## Table `stocks`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_stock` | `uuid` | Primary |
| `nom` | `text` |  |
| `id_zone` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `categories`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_categorie` | `uuid` | Primary |
| `nom` | `text` |  |
| `description` | `text` |  Nullable |
| `created_at` | `timestamptz` |  Nullable |
| `image_url` | `text` |  Nullable |

## Table `materiels`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_materiel` | `uuid` | Primary |
| `nom` | `text` |  |
| `reference` | `text` |  Unique |
| `description` | `text` |  Nullable |
| `etat` | `text` |  |
| `date_acquisition` | `date` |  |
| `id_categorie` | `uuid` |  |
| `id_stock` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `gerer`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_utilisateur` | `uuid` | Primary |
| `id_zone` | `uuid` | Primary |

## Table `tickets`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_ticket` | `uuid` | Primary |
| `lieu_utilisation` | `text` |  |
| `date_fin_prevue` | `timestamptz` |  |
| `date_creation` | `timestamptz` |  Nullable |
| `etat` | `text` |  |
| `code_remise` | `varchar` |  Nullable |
| `date_expiration_code` | `timestamptz` |  Nullable |
| `date_validation` | `timestamptz` |  Nullable |
| `motif_refus` | `text` |  Nullable |
| `id_demandeur` | `uuid` |  |
| `id_valideur` | `uuid` |  Nullable |
| `id_remetteur` | `uuid` |  Nullable |
| `id_zone` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `lignes_ticket`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_ligne_ticket` | `uuid` | Primary |
| `id_ticket` | `uuid` |  |
| `id_materiel` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `demandes_affectation`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_demande` | `uuid` | Primary |
| `date_demande` | `timestamptz` |  Nullable |
| `justification` | `text` |  |
| `etat` | `text` |  |
| `motif_refus` | `text` |  Nullable |
| `service_beneficiaire` | `text` |  |
| `date_debut` | `date` |  Nullable |
| `date_fin_prevue` | `date` |  Nullable |
| `id_demandeur` | `uuid` |  |
| `id_valideur` | `uuid` |  Nullable |
| `id_categorie` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `affectations`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_affectation` | `uuid` | Primary |
| `date_debut` | `date` |  |
| `date_fin_prevue` | `date` |  |
| `date_fin_effective` | `date` |  Nullable |
| `etat` | `text` |  |
| `id_materiel` | `uuid` |  |
| `id_beneficiaire` | `uuid` |  |
| `id_demande` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

## Table `notifications`

### Columns

| Name | Type | Constraints |
|------|------|-------------|
| `id_notification` | `uuid` | Primary |
| `message` | `text` |  |
| `type` | `text` |  |
| `date_envoi` | `timestamptz` |  Nullable |
| `lu` | `bool` |  Nullable |
| `id_utilisateur` | `uuid` |  |
| `created_at` | `timestamptz` |  Nullable |

