# Scalability Tuning

This guide provides instructions on how to tune your Supervisely installation for better performance and scalability. It covers two main aspects:

1. Increasing the number of replicas for key services
2. Tuning the PostgreSQL database for better performance

## Increasing Service Replicas

For high-load environments, you can increase the number of replicas for certain services to improve throughput and availability.

### Creating a docker-compose.override.yml

To increase the number of replicas for the `api` and `api-public` services, create a `docker-compose.override.yml` file in the Supervisely installation directory:

```bash
cd $(sudo supervisely where)
```

Create or edit the `docker-compose.override.yml` file with the following content:

```yaml
services:
  api:
    environment:
      POSTGRES_POOL_MAX: '20'
    deploy:
      replicas: 3

  api-public:
    environment:
      POSTGRES_POOL_MAX: '20'
    deploy:
      replicas: 3
```

The values provided above are just examples. You can adjust the number of replicas and pool size based on your server's load.\
If you notice "Timeout acquiring a connection. The pool is probably full" in the logs, you may need to increase the `POSTGRES_POOL_MAX` / replicas value.

After creating or modifying this file, apply the changes by redeploying the services:

```bash
sudo supervisely up -d
```

This configuration will start 3 replicas each of the `api` and `api-public` services, which will improve the stability and performance of the Supervisely platform.

`POSTGRES_POOL_MAX` is the maximum number of connections to the PostgreSQL database that each service can use. You can adjust this value based on your server's available resources.

## PostgreSQL Database Tuning

The PostgreSQL database is a critical component of Supervisely. Proper tuning can significantly improve overall system performance.

### Locating the PostgreSQL Configuration

The PostgreSQL data directory can be found at:

```bash
cd $(sudo supervisely where data)/db
```

The main configuration file is `postgresql.conf`, which contains various settings that can be tuned.

### Increasing Connection Limits

To increase the PostgreSQL connection limit to 1000:

1. Edit the `postgresql.conf` file:

```bash
cd $(sudo supervisely where data)/db
sudo nano postgresql.conf
```

2. Find and modify the following parameters:

```
max_connections = 1000          # increase from default (typically 100)
```

### Tuning PostgreSQL Based on Available RAM

PostgreSQL performance is heavily dependent on available memory. Here are recommended settings based on your server's total RAM:

#### For servers with 8GB RAM:

```
shared_buffers = 2GB            # 25% of RAM
effective_cache_size = 4GB      # 50% of RAM
maintenance_work_mem = 512MB    # For maintenance operations
work_mem = 20MB                 # Per connection for complex operations
```

#### For servers with 16GB RAM:

```
shared_buffers = 4GB            # 25% of RAM
effective_cache_size = 8GB      # 50% of RAM
maintenance_work_mem = 1GB      # For maintenance operations
work_mem = 40MB                 # Per connection for complex operations
```

#### For servers with 32GB RAM:

```
shared_buffers = 8GB            # 25% of RAM
effective_cache_size = 16GB     # 50% of RAM
maintenance_work_mem = 2GB      # For maintenance operations
work_mem = 80MB                 # Per connection for complex operations
```

#### For servers with 64GB RAM or more:

```
shared_buffers = 16GB           # 25% of RAM
effective_cache_size = 32GB     # 50% of RAM
maintenance_work_mem = 4GB      # For maintenance operations
work_mem = 160MB                # Per connection for complex operations
```

### Additional Important PostgreSQL Parameters

```
# Write-Ahead Log (WAL) settings
wal_buffers = 16MB              # Improves WAL performance
min_wal_size = 1GB              # Minimum size for WAL files
max_wal_size = 4GB              # Maximum size before checkpoint trigger
```

### Applying PostgreSQL Changes

After making changes to the PostgreSQL configuration, restart the database service:

```bash
sudo supervisely restart postgres
```

### Increasing PostgreSQL Container Memory Limit

After tuning the PostgreSQL configuration, you may need to increase the container memory limit to accommodate the new settings.\
To increase the PostgreSQL container memory limit, create or edit the `docker-compose.override.yml` file:

```bash
cd $(sudo supervisely where)
```

Add or modify the PostgreSQL service configuration:

```yaml
services:
  postgres:
    deploy:
      resources:
        limits:
          memory: 16G  # Adjust this value based on your server's available RAM
```

This setting allocates up to 16GB of memory to the PostgreSQL container. Adjust this value based on your server's total RAM.

You also need to adjust the `POSTGRES_SHM_SIZE` parameter in the `.env` file to match the new `shared_buffers` value:

```bash
cd $(sudo supervisely where)
sudo nano .env
```

Find and modify the following parameter:

```bash
POSTGRES_SHM_SIZE=8G  # Adjust this value based on your shared_buffers setting
```

After making these changes, apply them by redeploying the services:

```bash
sudo supervisely up -d postgres
```
