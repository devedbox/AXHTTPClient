#酱游科技数据模型协议
##JYObjectModule[![Build Status](https://travis-ci.org/jiangtour/JYObjectModule.svg?branch=master)](https://travis-ci.org/jiangtour/JYObjectModule)[![Version](https://img.shields.io/cocoapods/v/JYObjectModule.svg?style=flat)](http://cocoapods.org/pods/JYObjectModule)[![License](https://img.shields.io/cocoapods/l/JYObjectModule.svg?style=flat)](http://cocoapods.org/pods/JYObjectModule)[![Platform](https://img.shields.io/cocoapods/p/JYObjectModule.svg?style=flat)](http://cocoapods.org/pods/JYObjectModule)

> |:-------------|:-------------|
> | 主题 | 酱游科技数据模型接口协议 |
> | 版本|  0.1.0 |
> | 内容| 数据模型定义|
> | 关键字|  开发、协同、接口，数据字典 |
> | 参考文档|  无 |
> | 创建时间|  2016/08/22 |
> | 创建人|  酱游科技技术部艾星 |
> |最新发布日期|  2016/08/24 |
> | 创建时间|  2016/08/22 |

> |:-------------|:-------------|:---------------|
> | 技术部艾星|  2016/08/22 |文档创建|
> | 技术部| 2016/08/24|文档完善|

> |:-------------|:-------------:|:-------------:|:---------------|
> | objectId|  对象Id |string|服务器分配的唯一对象Id |
> | userId | 当前用户Id | string | 当前用户Id |
> | index | 对象索引 | int | 对象索引值，值小于0是不生效，默认值为-1 |
> | atCreation | 对象创建时间 | long | 对象创建时间 |
> | atUpdation | 对象变更时间 | long | 对象变更时间，值小于0表示不生效，默认值为-1 |
> | descriptions | 附加表述 | string | 附加描述，没有可忽略 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | url | 图片链接地址 | string | 图片链接地址 |

> |:-------------|:-------------:|:-------------:|:---------------|
> |  |  |  |  |
> | imageURL | banner的图片 | string | banner的图片链接 |
> | url | banner的链接 | string | banner的链接，用于跳转 |
> | priority | banner的优先级 | int | 从0开始，表示banner的显示优先级，区别于index：index表示存储索引 |
> | type | 类型 | int | banner类型，-1表示此字段不生效 |
> | subtype | 子类型 | int | banner子类型，-1表示此字段不生效 |
> | referenceId | 引用id | string | 引用App内部资源id |

> |:-------------|:-------------:|:-------------:|:---------------|
> | longitude | 经度 | double | 地理位置经度 |
> | latitude | 纬度 | double | 地理位置纬度 |
> | province | 省份 | string | 省份名称 |
> | city | 城市 | string | 城市名称 |
> | district | 区县 | string | 区县名称 |
> | street | 街道 | string | 街道名称 |
> | address | 扩展描述 | string | 详细地址描述 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | content | 评论内容 | string | 评论内容 |
> | images | 评论图片 | List<_kind_of_JYImageObject> | 评论图片 |
> | user | 发表评论的用户 | _kind_of_JYUserObject | 发表评论用户实体 |
> | atUser | 被评论评论内容的用户 | _kind_of_JYUserObject | 被评论评论内容的用户 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | avatar | 头像 | string | 图片链接 |
> | nickname | 昵称 | string | 用户昵称，不要使用emoji等字符 |
> | phone | 注册的电话号码 | string | 注册时使用的手机号码 |
> | gender | 性别 | int | 性别，0代表默认，1代表男性，2代表女性 |
> | birthday | 生日 | string | 生日字符串 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | user | 内容产生用户 | _kind_of_JYUserObject | 内容产生用户 |
> | title | 内容标题 | string | 内容标题 |
> | detail | 内容摘要 | string | 内容摘要 |
> | content | 文字内容 | string | 文字内容 |
> | images | 图片内容 | List<_kind_of_JYImageObject> | 图片内容 |
> | readCount | 阅读数量 | int | 帖子阅读数量 |
> | commentCount | 评论数量 | int | 帖子评论数量 |
> | liked | 是否点赞 | boolean | 是否点赞帖子 |
> | likeCount | 点赞数量 | int | 点赞数量 |
> | shareCount | 分享数量 | int | 分享数量 |
> | comments | 评论列表 | List<JYCommentObject> | 评论实体列表，默认3条 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | storage | 实际string内容 | string | 实际内容 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | content | 推送内容 | string | 推送内容 |
> | subtype | 推送子类型 | int | 推送子类型 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | name | 实名名字 | string | 用户真实名字 |
> | identifier | 身份证件编号 | string | 身份证 |
> | phone | 联系方式 | string | 注册时使用的手机号码 |
> | state | 认证状态 | int | 认证状态描述 |
> | substate | 认证子状态 | int | 认证子状态 |
> | statements | 状态描述 | string | 状态描述 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | state | 订单状态 | int | 订单状态 |
> | substate | 订单子状态 | int | 订单子状态 |
> | product | 产品 | _kind_of_JYProductObject | 订单来源产品 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | title | 产品名称 | string | 产品名称 |
> | detail | 产品详细描述 | string | 产品详细描述 |
> | thumbnail | 封面图链接 | string | 封面图链接 |
> | images | 图片介绍 | List<_kind_of_JYImgaeObject> | 产品图片 |
> | url | 产品介绍链接 | string | 产品介绍H5链接 |
> | state | 产品状态 | int | 产品状态 |
> | substate | 产品子状态 | int | 产品子状态 |
> | characteristics | 产品特性 | List<_kind_of_JYIntegerObject>  | 产品特性 |
> | categories | 产品类别 | List<_kind_of_JYProductCategoryObject> | 需要实例化规格的类型 |

####说明
> |:-------------|:-------------:|:-------------:|:---------------|
> | superId | 父节点Id | string | 父节点id |
> | title | 对象标题 | string | 对象标题 |
> | detail | 对象详情 | string | 对象详情 |
> | children | 子节点数组 | List<_kind_of_JYChainObject> | 子节点数组 |

> |:-------------|:-------------:|:-------------:|:---------------|
> |  |  |  |  |

> |:-------------|:-------------:|:-------------:|:---------------|
> | index | 当前页码 | int | 当前页码 |
> | pageCount | 每页包含的纪录数 | int | 每页包饭的纪录数 |
> | totalCount | 总数量 | int | 总数量 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | amount | 钱包余额 | long | 钱包余额精确到分 |
> | withdrawal | 可提现余额 | long | 可提现余额 |
> | blocked | 冻结资金 | long | 冻结资金 |
> | income | 累计收入 | long | 累计收入 |
> | outcome | 累计支出 | long | 累计支出 |

####说明
> |:-------------|:-------------:|:-------------:|:---------------|
> | state | 提现状态 | int | 提现状态，待定义 |
> | substate | 提现子状态 | int | 待定义 |
> | statements | 状态描述 | string | 例如失败原因描述 |
> | account | 提现账户 | string | 支付宝账户 |
> | amount | 提现金额 | double | 提现金额 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | user | 贡献用户 | _kind_of_JYUserObject | 贡献用户 |
> | type | 返现类型 | int | 待定义 |
> | subtype | 返现子类型 | int | 待定义 |
> | statements | 返现描述 | string | 返现描述 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | name | 收货人姓名 | string | 收货人姓名 |
> | phone | 联系电话 | string | 联系电话 |
> | defaulted | 是否是默认地址 | boolean | 是否是默认收货地址 |
> | location | 地址信息 | _kind_of_JYLocationObject | 地址信息 |

####说明
> |:-------------|:-------------:|:-------------:|:---------------|
> | integer | 实际int值 | int | 实际int值 |

> |:-------------|:-------------:|:-------------:|:---------------|
> | title | 标题描述 | string | 标题描述 |
> | detail | 详细描述 | string | 详细描述 |
> | amount | 金额大小 | long | 金额大小 |
> | type | 类型 | int | 类型 |
> | subtype | 子类型 | int | 子类型 |
> | state | 状态 | int | 状态 |
> | substate | 子状态 | int | 子状态 |


> |:-------------|:-------------:|:-------------:|:---------------|
> |  |  |  |  |

### JYUserVerifyResponseObject
> |:-------------|:-------------:|:-------------:|:---------------|
> | userId | 用户Id | string | 注册成功之后服务器返回的用户id |
> | token | 授权码 | string | 注册成功之后服务器返回的授权码 |

####说明
> |:-------------|:-------------:|:-------------:|:---------------|
> |  |  |  |  |

####说明
> |:-------------|:-------------:|:-------------:|:---------------|
> | amount | 金额 | double | 金额 |
> | type | 类型 | int | 类型 |
> | subtype | 子类型 | int | 子类型 |
> | channel | 渠道 | int | 渠道 |

####说明

> |:-------------|:-------------:|:-------------:|:---------------|
> |  |  |  |  |

####说明

> |:-------------|:-------------:|:-------------:|:---------------|
> |  |  |  |  |

####说明