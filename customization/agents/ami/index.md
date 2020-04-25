If, for some reason, your computer doesn't meet the requirements, hardware (no GPU) or software (no CUDA or nvidia-docker), there is a quick way to try training & inference with Supervisely on Amazon EC2.

We have prepared an AMI (ready-to-use Amazon Machine Image) that already has every component prepared. If you have an account on EC2, deploying Supervisely agent is easy as one-two-three: 

## Step 1: Login into Amazon EC2 Console

[Sign in](https://console.aws.amazon.com/console/home) into your account. We suppose you already have an account on AWS. If not, [signup](https://portal.aws.amazon.com/billing/signup).

![](screenshot-signin-aws-amazon-com-signin-1533487048057.jpg)


## Step 2: Select "Oregon" zone

Because AMI is specific for availability zone, select "Oregon" zone is top right menu.

![](screenshot-us-west-2-console-aws-amazon-com-ec2-v2-home-1533486910173.png)


## Step 3: Find "Supervisely" AMI

Click "Launch Instance". You will see "Choose an Amazon Machine Image" screen. Select "Community AMIs" and type "Supervisely" in the search field.

Find Supervisely-P2 ("ami-15d3886d") image and click "Select".

![](screenshot-us-west-2-console-aws-amazon-com-ec2-v2-home-1533486949823.png)



## Step 4: Run the GPU instance

On a next step select "GPU compute" filter and select "p2.*" instance type. We suggest using "p2.xlarge".

By default 20 GiB storage would be used. This is a minimum required volume size, because agent will download pretty large docker images. You can also attach additional EBS volume and create a symlink to `~/.supervisely-agent` - this is where your model weights and images will be stored.

Click "Review and Launch" to start your instance.

![](screenshot-us-west-2-console-aws-amazon-com-ec2-v2-home-1533486990103.png)



## Step 5: Copy-paste command in the instance terminal

Connect to your new instance using ssh. Follow [those steps](../add_delete_node/add_delete_node.md) to generate the agent deployment command and run it on your Amazon instance. 

You can always stop your instance when you don't need your GPU resources to save money and start it again later. Supervisely agent should run automatically on instance startup. 
