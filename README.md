# discord_notifier

## 使い方

### AWSへの接続

```console
$ aws login
```

### terraform初期化

ローカルの場合

```console
$ terraform init
```

S3を使う場合

```console
$ envsubst < backend.template > backend.hcl
$ terraform init -backend-config=backend.hcl
```

### デプロイ

事前チェック

```console
$ terraform fmt
$ terraform validate
```

現環境との差分チェックと適用。

```console
$ terraform plan
$ terraform apply -auto-approve
```
