In Enterprise Edition we support data storage in Azure Blob Storage or any S3 compatible storage (i.e. AWS S3).

## How we store files

Supervisely uses `DATA_PATH` from `.env` (defaults to `/supervisely/data`) to keep caches, database and etc. But we are interested in `storage` subfolder generated content, like uploaded images or neural networks are stored.

You can find two subfolders here:

- `<something>-public/`
- `<something>-private/`

That's because we maintain the same structure in local storage as if you would use a remote storage. In that case those two folders are *buckets* or *containers*. You may notice that one has "public" in it's name, but it only reflects the kind of data we store in it. Both buckets are private and does not provide anonymous read.

## Configure Supervisely to use S3

Edit `.env` configuration file - you can find it by running `supervisely where` command. 

Change `STORAGE_PROVIDER` from `http` (local hard drive) to `minio` (S3 storage backend).

Also, you need to provide `STORAGE_ACCESS_KEY` and `STORAGE_SECRET_KEY` credentials along with endpoint of your S3 storage.

For example, here are settings for Amazon S3:

- `STORAGE_ENDPOINT=s3.amazonaws.com`
- `STORAGE_PORT=443`

So in the end, here is how your `.env` settings could look like:

```
JUPYTER_DOWNLOAD_FILES_BEFORE_START=true
STORAGE_JUPYTER_SYNC=true
STORAGE_PROVIDER=minio
STORAGE_ENDPOINT=s3.amazonaws.com
STORAGE_PORT=443
STORAGE_ACCESS_KEY=<hidden>
STORAGE_SECRET_KEY=<hidden>
```

## Configure Supervisely to use Azure Blob Storage

Edit `.env` configuration file - you can find it by running `supervisely where` command. 

Change `STORAGE_PROVIDER` from `http` (local hard drive) to `azure` (Azure storage backend).

Also, you need to provide `STORAGE_ACCESS_KEY` (your storage account name) and `STORAGE_SECRET_KEY` (secret key) credentials along with endpoint of your blob storage.

Here is how your `.env` settings could look like:

```
JUPYTER_DOWNLOAD_FILES_BEFORE_START=true
STORAGE_JUPYTER_SYNC=true
STORAGE_ACCESS_KEY=<account name>
STORAGE_ENDPOINT=https://<account name>.blob.core.windows.net
STORAGE_PROVIDER=azure
STORAGE_SECRET_KEY=<secret key 88 chars long or so: aflmg+wg23fWA+6gAafWmgF4a>
```

## Migration from local storage

Now, copy your current storage to an S3. As we mentioned before, because we maintain the same structure in local filesystem, copying will be enough.

We suggest to use [minio/mc](https://github.com/minio/mc) to copy the files.

Run `minio/mc` docker image and execute the following commands:

```
mc config host add s3 https://s3.amazonaws.com <YOUR-ACCESS-KEY> <YOUR-SECRET-KEY>
mc cp <DATA_STORAGE_FROM_HOST>/<your-buckets-prefix>-public s3/<your-buckets-prefix>-public/
mc cp <DATA_STORAGE_FROM_HOST>/<your-buckets-prefix>-private s3/<your-buckets-prefix>-private/
```

Finally, restart services to apply new configuration: `supervisely up -d`.

## Keys from IAM Role

If you want to use [IAM Role](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html#instance-metadata-security-credentials) you must specify `STORAGE_IAM_ROLE=<role_name>` in .env file then `STORAGE_ACCESS_KEY` and `STORAGE_SECRET_KEY` variables can be ommited. 

IAM Roles are only supported for AWS S3.

## Frontend caching

Since AWS and Azure can be quite price in case of heavy reads, we enable image caching by default.

If the image is not in the preview cache but in the STORAGE cache it will be generated and put into previews cache, but it will not be fetched from the remote server.

Here are the default values (you can alter them via `docker-compose.override.yml` file):

```
services:
  proxy:
    environment:
      CACHE_PREVIEWS_SIZE: 1g
      CACHE_PREVIEWS_EXPIRES: 12h
      CACHE_STORAGE_SIZE: 10g
      CACHE_STORAGE_EXPIRES: 7d
      CACHE_IMAGE_CONVERTER_SIZE: 10g
      CACHE_IMAGE_CONVERTER_EXPIRES: 7d
```

## Links plugin S3 support

If you already have some files on Amazon S3 and you don't want to upload and store those files in Supervisely, you can use "Links" plugin to link the files to Supervisely server.

Instead of uploading actual files (i.e. images), you will need to upload .txt file(s) that contains a list of URLs to your files. If your URLs are publicly available (i.e. link looks like `https://s3-us-west-2.amazonaws.com/test1/abc` and you can open it in your web browser directly), you are good. If your files are protected, you will need to provide URLs with [S3 protocol](https://gpdb.docs.pivotal.io/510/admin_guide/external/g-s3-protocol.html) as `s3://s3-us-west-2.amazonaws.com/test1/abc` and provide `REMOTE_STORAGE_*` variables like this:

Create a new file `docker-compose.override.yml` under `cd $(sudo supervisely where)`:
```
services:
  http-storage:
    environment:
      REMOTE_STORAGE_ENDPOINT: s3.amazonaws.com
      REMOTE_STORAGE_PORT: 443
      REMOTE_STORAGE_ACCESS_KEY: # access key
      REMOTE_STORAGE_SECRET_KEY: # secret key
      REMOTE_STORAGE_REGION: # region if applicable
      REMOTE_STORAGE_IAM_ROLE: # IAM role name if applicable
```
