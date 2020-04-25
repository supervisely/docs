In Enterprise Edition we support data storage in any S3 compatible storage.

## How we store files

Supervisely uses `DATA_PATH` from `.env` (defaults to `/supervisely/data`) to keep caches, database and etc. But we are interested in `storage` subfolder generated content, like uploaded images or neural networks are stored.

You can find two subfolders here:

- `<something>-public/`
- `<something>-private/`

That's because we maintain the same structure in local storage as if you would use S3. In that case those two folders are *buckets*, with different permissions:

- `<something>-public/` - Read access for anonymous users. Disallow listing for anonymous users. Read/Write access for authorized users
- `<something>-private/` - Read/Write access for authorized users

We need the read access for anonymous users so that we can load images directly from s3 in web browser. We generate unique hashes for image names, so there is no way someone can guess url.

## Configure Supervisely to use S3

Edit `.env` configuration file - you can find it by running `supervisely where` command. 

Change `STORAGE_PROVIDER` from `http` (local hard drive) to `minio` (S3 storage backend).

Also, you need to provide `STORAGE_ACCESS_KEY` and `STORAGE_SECRET_KEY` credentials along with endpoint of your S3 storage.

For example, here are settings for Amazon S3:

- `STORAGE_ENDPOINT=s3.amazonaws.com`
- `STORAGE_PORT=443`

So in the end, here is how your `.env` settings could look like:

```
`STORAGE_PROVIDER=minio`
`STORAGE_ENDPOINT=s3.amazonaws.com`
`STORAGE_PORT=443`
`STORAGE_ACCESS_KEY=<hidden>`
`STORAGE_SECRET_KEY=<hidden>`
```

## Migration from local storage to S3

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
