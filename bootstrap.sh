#!/usr/bin/env bash

aws s3api create-bucket --bucket starta-terraform-v1 --region eu-north-1 --create-bucket-configuration LocationConstraint=eu-north-1 --profile telran
