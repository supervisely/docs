# Data folder structure

Your installation of Supervisely platform uses the `DATA_PATH` value to configure where to store its persistent data. By default, this value is set to `/supervisely/data`. This guide explains what kind of data can be found inside this folder, requirements and the cleanup.

| Folder      | Avg Size      | Fast drive   | Can be safely cleaned |
|-------------|---------------|--------------|-----------------------|
| db          | 2-10Gb+       | required     | No                    |
| logs        | 10Mb - 4Gb+   | not required | Yes                   |
| net-server  | 1Mb           | not required | Almost                |
| proxy_cache | 100Mb - 10Gb+ | preferable   | Yes                   |
| rabbitmq    | 100Mb - 2Gb   | preferable   | Almost                |
| redis       | 10Mb - 2Gb    | not required | Almost                |
| redis-json  | 10Mb - 1Gb    | not required | Almost                |
| storage     | 10Gb - 100Gb+ | not required | No                    |

```
.
├── db
├── logs
├── net-server
├── proxy_cache
├── rabbitmq
├── redis
├── redis-json
└── storage
```

{% hint style="danger" %}
Never set `DATA_PATH` pointing to a network share (NFS/SMB/ESB/etc), because it affects the performance significantly. Instead, you should just symlink every folder that doesn't require a fast drive to a network share. In most cases it's just the "storage" folder.
{% endhint %}

### db

This subfolder is used by PostgreSQL relational database. This is the primary database Supervisely uses to store your annotations, users, dataset structures, and so on. Contents of this folder are shared with `postgres` Docker container. The size of the database usually does not exceed 10 Gb.

{% hint style="warning" %}
It's advised to store this folder on a fast SSD drive. If you store it on a slow HDD drive, you may experience performance issues.
{% endhint %}

{% hint style="warning" %}
This database does not store your actual images or videos, only URLs or file hashes.
{% endhint %}

Fast drive: required for the best performance
Can be safely cleaned: No, you will lose all your annotations and projects.

### logs

This subfolder is used by [Vector](https://vector.dev) logs parsing and transforming service (`vector` Docker container). Vector dumps the logs into the `logs` subfolder in Zstandard JSON lines format. Logs can be easily obtained by running the `sudo supervisely troubleshoot` command.

{% hint style="warning" %}
By default we do not clean this folder automatically.
{% endhint %}

Fast drive: optional, doesn't affect the performance
Can be safely cleaned: Yes

### proxy_cache

This subfolder is used by Nginx to cache certain resources for fast access of frequently used assets, mainly small previews of images and video frames. The size of this folder can be configured via `CACHE_STORAGE_SIZE` setting.

Fast drive: preferred, but not required
Can be safely cleaned: Yes

### rabbitmq

This subfolder is used by RabbitMQ message broker. This is a temporary storage to queue tasks. If you clean this folder, running tasks will be stopped an may end up in an invalid state

Fast drive: preferred, but not required
Can be safely cleaned: Almost

### redis & redis-json

This subfolder is used by Redis cache database. This is a storage for temporary data that is also available in the main database (PostgreSQL), but is duplicated for fast access. For example, users' online status is cached there. If you clean this folder, some minor information such as real-time logs can be lost

Fast drive: optional, doesn't affect the performance
Can be safely cleaned: Almost

### storage

This subfolder is used by various services to store permanent files, such as images and other assets.

Some of the examples:

- Images
- Videos
- Point cloud files
- Model checkpoints
- Application posters
- Jupyter notebooks
- Task data

Usually, we generate a unique file name or use file hash instead of the original file name.

{% hint style="warning" %}
You can configure Supervisely to [use remote storage](/enterprise-edition/advanced-tuning/s3), such as S3, instead of this folder. In this case this folder will be empty, and actual files will be stored as blob objects in the selected cloud.
{% endhint %}

{% hint style="warning" %}
You will find two subfolders, `*-public` and `*-private` inside this folder. Those names do not reflect the actual privacy of folder contents; both folders are completely private and not publicly accessible; those names are legacy.
{% endhint %}

Fast drive: completely optional, required in very rare cases
Can be safely cleaned: No, you will lose all your images, videos, and other assets.
