# ECS on GPU EC2：ECSクラスターで動かすCUDAコンテナ基盤自動構築

<p align="center">
  <img src="sources/aws.png" alt="animated">
</p>

![Git](https://img.shields.io/badge/GIT-E44C30?logo=git&logoColor=white)
![gitignore](https://img.shields.io/badge/gitignore%20io-204ECF?logo=gitignoredotio&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?logo=terraform&logoColor=white)
[![Python](https://img.shields.io/badge/Python-3.12-blue.svg?logo=python&logoColor=blue)](https://www.python.org/)
![PyTorch](https://img.shields.io/badge/PyTorch-2.1.0-blue.svg?logo=PyTorch&logoColor=white)
[![Docker Compose](https://img.shields.io/badge/Docker%20Compose-v3-blue.svg)](https://docs.docker.com/compose/)
![Commit Msg](https://img.shields.io/badge/Commit%20message-Eg-brightgreen.svg)
![Code Cmnt](https://img.shields.io/badge/code%20comment-Ja-brightgreen.svg)

このリポジトリは、Terraformを使用してAWS上にGPU搭載EC2インスタンスで動作するECSクラスタを自動構築するためのものです。NVIDIAドライバーがプリインストールされたAMIを使用し、CUDAコンテナの実行基盤を容易に構築できます。

## 概要
深層学習やGPGPU計算などのGPUを必要とするワークロードを、ECS(Elastic Container Service)を用いてコンテナ化し、容易にスケーリング、管理することを目的としています。Terraformによるインフラのコード化により、再現性と変更容易性を高めています。

## 特徴
+ CUDA対応GPUインスタンス(g4dn.xlarge)をECSクラスタで利用可能
+ NVIDIAドライバープリインストールAMIの使用で、セットアップの手間を削減
+ Terraformによるインフラのコード化で、容易な構築、変更、破棄が可能
+ 将来的な拡張性を考慮した設計

## 基本インフラの構築

以下のコードを実行してインフラを構築します。
```
bin/terraform_apply
```

### 停止
以下のコードを実行すると停止できます。
```
bin/terraform_destroy
```
