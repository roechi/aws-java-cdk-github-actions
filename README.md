
# AWS-Java-CDK GitHub Actions
[![Docker Image Build](https://github.com/roechi/aws-java-cdk-github-actions/actions/workflows/build-docker-image.yml/badge.svg)](https://github.com/roechi/aws-java-cdk-github-actions/actions/workflows/build-docker-image.yml)
[![GitHub Release](https://img.shields.io/github/release/roechi/aws-java-cdk-github-actions.svg?style=flat)](https://github.com/roechi/aws-java-cdk-github-actions/releases) 

AWS-Java-CDK GitHub Actions allow you to run `cdk deploy` and `cdk diff` and ... on your pull requests to help you review.

## Supported languages

- Java (14)

but also:
- TypeScript
- JavaScript
- Python


## Example usage

```yaml
on: [push]

jobs:
  aws_cdk:
    runs-on: ubuntu-latest
    steps:
      - name: cdk bootstrap
        uses: parameswaranvv/aws-java-cdk-github-actions@v1
        with:
          cdk_subcommand: 'bootstrap'
          actions_comment: false
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'
          CDK_DEFAULT_ACCOUNT: ${{ secrets.CDK_DEFAULT_ACCOUNT }}
          CDK_DEFAULT_REGION: ${{ secrets.CDK_DEFAULT_REGION }}

      - name: cdk diff
        uses: parameswaranvv/aws-java-cdk-github-actions@v1
        with:
          cdk_subcommand: 'diff'
          actions_comment: true
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'

      - name: cdk deploy
        uses: parameswaranvv/aws-java-cdk-github-actions@v1
        with:
          cdk_subcommand: 'deploy'
          cdk_stack: 'stack1'
          cdk_args: '--require-approval never'
          actions_comment: false
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'

      - name: cdk synth
        uses: parameswaranvv/aws-java-cdk-github-actions@v1.1.0
        with:
          cdk_subcommand: 'synth'
          cdk_version: '1.16.2'
          working_dir: 'src'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'
```

## Inputs

- `cdk_subcommand` **Required** AWS CDK subcommand to execute (synth, diff, deploy, doctor,...).
- `cdk_version` AWS CDK version to install. (default: 'latest')
- `cdk_stack` AWS CDK stack name to execute. (default: '*')
- `working_dir` AWS CDK working directory. (default: '.')
- `actions_comment` Whether or not to comment on pull requests. (default: true)
- `debug_log` Enable debug-log. (default: false)

## Outputs

- `status_code` Returned status code.

## ENV

- `AWS_ACCESS_KEY_ID` **Optional**
- `AWS_SECRET_ACCESS_KEY` **Optional**
- `GITHUB_TOKEN` Required for `actions_comment=true`

# A note on AWS credentials
Using long-living credentials and injecting them into your workflow environment is generally a bad habit. 

Github recently improved the workflow authentication experience by injecting an Open Id Connect Token into your workflow environment. I recommend favouring this approach over using long living credentials. You can read more about this in [this blog post](https://github.blog/changelog/2021-10-27-github-actions-secure-cloud-deployments-with-openid-connect/). 

To easily configure your AWS environment in any workflow, I recommend using the [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials), it's really straight forward.
