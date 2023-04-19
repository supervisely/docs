# Data folder structure

Your installation of Supervisely platform uses the `DATA_PATH` value to configure where to store its persistant data. By default, this value is set to `/supervisely/data`. This guide explains what kind of data can be found inside this folder.

There are the following subfolders:

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

### db

This subfolder is used by PostgreSQL relational database. This is the primary database Supervisely uses to store your annotations, users, dataset structures, and so on. Contents of this folder are shared with `postgres` Docker container. The size of the database usually does not exceed 10 Gb.

{% hint style="warning" %}
This database does not store your actual images or videos, only URLs or file hashes.
{% endhint %}

Can be safely cleaned: No, you will lose all your annotations and projects.

### logs

This subfolder is used by Logstash logs parsing and transforming service (`logstash` Docker container). The actual logs are collected via [Vector](https://vector.dev) service (`vector` Docker container). Logstash dumps logs in the `logs` subfolder in gzipped JSON format. Logs can be easily obtained by running the `sudo supervisely troubleshoot` command.

{% hint style="warning" %}
By default we do not clean this folder automatically.
{% endhint %}

Can be safely cleaned: Yes

### proxy_cache

This subfolder is used by Nginx to cache certain resources for fast access of frequently used assets, mainly small previews of images and video frames. The size of this folder can be configured via `CACHE_STORAGE_SIZE` setting.

Can be safely cleaned: Yes

### rabbitmq

This subfolder is used by RabbitMQ message broker. This is a temporary storage to queue tasks.

Can be safely cleaned: Yes

### redis & redis-json

This subfolder is used by Redis cache database. This is a storage for temporary data that is also available in the main database (PostgreSQL), but is duplicated for fast access. For example, users' online status is cached there.

Can be safely cleaned: Yes

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

Usually, we hash file contents and use file hash instead of the original file name.

{% hint style="warning" %}
You can configure Supervisely to [use remote storage](/enterprise-edition/advanced-tuning/s3), such as S3, instead of this folder. In this case this folder will be empty, and actual files will be stored as blob objects in the selected cloud.
{% endhint %}

{% hint style="warning" %}
You will find two subfolders, `*-public` and `*-private` inside this folder. Those names do not reflect the actual privacy of folder contents; both folders are completely private and not publicly accessible; those names are legacy.
{% endhint %}

Can be safely cleaned: No, you will lose all your images, videos, and other assets.
