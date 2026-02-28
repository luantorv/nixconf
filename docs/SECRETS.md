# Secrets Management

Secrets are managed with [sops-nix](https://github.com/mic92/sops-nix) and encrypted with [age](https://age-encryption.org), using the user's SSH ed25519 key as the identity. Encrypted files are safe to commit to a public repository.

## How it works

- `secrets/secrets.yaml` stores all secrets encrypted. It lives in the repo.
- `secrets/.sops.yaml` tells sops which age keys can decrypt each file. It is plain text.
- On activation, sops-nix decrypts secrets and places them at the declared paths with the correct permissions.
- The age key is derived from your SSH private key. No separate age key needs to be generated or stored manually.

---

## Setup on a new machine

There is a one-time bootstrapping step because of a circular dependency: sops needs your SSH key to decrypt secrets, but your SSH key is stored encrypted in sops. The solution is to generate a fresh key, register it, and re-encrypt the secrets before applying the configuration.

### 1. Generate an SSH key

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
```

### 2. Derive the age key and store it where sops expects it

```bash
mkdir -p ~/.config/sops/age
nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt
chmod 600 ~/.config/sops/age/keys.txt
```

### 3. Get the public age key for this machine

```bash
nix run nixpkgs#ssh-to-age -- -i ~/.ssh/id_ed25519.pub
```

This prints something like `age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`. Copy it.

### 4. Register the key in `.sops.yaml`

Add the new key to `secrets/.sops.yaml`:

```yaml
keys:
  - &laptop age1xxxxxxx...   # existing key
  - &newmachine age1yyyyyyy... # new key

creation_rules:
  - path_regex: secrets/.*\.yaml$
    key_groups:
      - age:
          - *laptop
          - *newmachine
```

### 5. Re-encrypt existing secrets for the new key

```bash
nix run nixpkgs#sops -- updatekeys secrets/secrets.yaml
```

Commit the updated `secrets/secrets.yaml` and `secrets/.sops.yaml`.

### 6. Apply the configuration

```bash
sudo nixos-rebuild switch --flake ~/nixconf#laptop
```

---

## Adding a new secret

### 1. Edit the secrets file

sops decrypts the file, opens your editor, and re-encrypts on save.

```bash
nix run nixpkgs#sops -- secrets/secrets.yaml
```

Add your secret following the existing YAML structure:

```yaml
ssh:
    id_ed25519: |
        -----BEGIN OPENSSH PRIVATE KEY-----
        ...
    id_ed25519.pub: "ssh-ed25519 AAAA..."
some_service:
    api_key: "your-secret-value"
```

### 2. Declare it in `modules/home/sops.nix`

```nix
sops.secrets = {
  "some_service/api_key" = {
    path = "${globalVars.homeDirectory}/.config/some-service/api_key";
    mode = "0600";
  };
};
```

### 3. Rebuild

```bash
sudo nixos-rebuild switch --flake ~/nixconf#laptop
```

---

## Editing an existing secret

Same as adding one — open the file with sops and edit the value:

```bash
nix run nixpkgs#sops -- secrets/secrets.yaml
```

No need to re-declare anything in Nix unless the key name or destination path changes.

---

## What must never enter the repository

| File | Reason |
|---|---|
| `~/.ssh/id_ed25519` | Private SSH key |
| `~/.config/sops/age/keys.txt` | Derived age private key |

The `.gitignore` at the repo root covers common cases, but these files live outside the repo directory so they are not at risk under normal circumstances.
