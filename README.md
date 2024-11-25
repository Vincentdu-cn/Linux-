# Linux等保修复一键脚本
Linux等保修复一键脚本，包含syslog读取、配置审计规则、配置密码策略、配置登录失败次数及锁定策略等功能。
## 生产环境慎用一键修复，更改密码策略前先修改密码符合新的密码策略!!!
```shell
password requisite pam_cracklib.so retry=3 minlen=8 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
```

这一行配置是 PAM中 `pam_cracklib.so` 模块的设置，用于定义密码复杂性策略。这些选项的含义：

* `retry=3`：用户在输入新密码时有 3 次尝试机会。如果在 3 次尝试后仍未输入符合策略的密码，密码更改将失败。
* `minlen=8`：密码的最小长度为 8 个字符。注意，这个长度可能会受到其他复杂性要求的影响，从而需要更长的密码。
* `difok=3`：新密码与旧密码之间至少需要有 3 个字符不同。
* `ucredit=-1`：密码中至少需要包含 1 个大写字母（负值表示“至少”的意思）。
* `lcredit=-1`：密码中至少需要包含 1 个小写字母。
* `dcredit=-1`：密码中至少需要包含 1 个数字。
* `ocredit=-1`：密码中至少需要包含 1 个特殊字符（如 `!@#$%^&*` 等）。

## 运行脚本
```shell
chmod +x config_update.sh
./config_update.sh
```

![0YBBQ$NZGK9W F2{}PS588V](https://github.com/user-attachments/assets/8cb0da17-ef53-4d8b-ac7f-2241a5c49551)
