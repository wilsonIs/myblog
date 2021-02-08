---
layout: post
title: 接口前置技改优化成果小结
category: experience
---


## 插件信息

插件名：newfas

插件号：B0001122

环境：产线

前置版本：v3.0.7

前置入口：报销单

上线时间：20201231

前置接口：

- /caiku/newfas/bill/query_filter_type_list.json
- /caiku/newfas/bill/query_my_refund_bill_list.json

## 埋点数据分析

### 超时及调用异常统计

- 数据范围：20210101-2021011

| 埋点                  | 埋点描述                         | 计数 | 总调用次数 | 占比 |
| :-------------------- | -------------------------------- | ---- | ---------- | ---- |
| api-prefetch-error    | 调用native prefetch api 错误     | 0    | 8705       | 0%   |
| api-prefetch-time-out | 调用native prefetch api 超时(5s) | 147  | 8705       | 1.7% |

### 接口耗时统计

- 数据范围：20210111当天1000条数据，倒序，取95%数据（丢弃可能受网络等其它因素影响的5%数据）
- CAT接口耗时说明：接口数据来自query_my_refund_bill_list接口，统计范围pt >= 20210101
- CAT接口耗时查询地址：[CAT](https://cat.pinganfu.net/cat/r/t?domain=fcsmbiz-http&date=2021011117&ip=All&type=URL)

| 埋点                               | 前置接口耗时(95%)/ms | CAT接口耗时(95%)/ms | 节约时间/ms |
| ---------------------------------- | :------------------- | ------------------- | ----------- |
| api-prefetch-spending-time-per-url | 148.8ms              | 353.8               | 205         |

## 小结

在抽样统计的数据内：

1、报销单入口接口前置优化后，节约时间约**205ms**

2、调用的native api 比较可靠，没有发现 error

3、存在一定的调用超时，而CAT统计到的前置接口最大耗时为1.2s，超时设置可以考虑降低至2s
