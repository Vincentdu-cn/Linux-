# Linux等保修复一键脚本
Linux等保修复一键脚本，包含syslog读取、配置审计规则、配置密码策略、配置登录失败次数及锁定策略等功能。
## 生产环境慎用!!!
## pam_faillock放在正确的位置
```shell
auth    [success=1 default=ignore]   pam_unix.so nullok

# 引用pam_faillock.so模块
auth    [default=die]                pam_faillock.so authfail audit deny=5 unlock_time=600 fail_interval=900
auth    sufficient                   pam_faillock.so authsucc audit deny=5 unlock_time=600 fail_interval=900

auth    requisite                    pam_deny.so
auth    required                     pam_permit.so
auth    optional                     pam_cap.so
```

1. **​`auth [success=1 default=ignore] pam_unix.so nullok`​**：

    * 这是一个条件跳转配置。如果 `pam_unix.so` 成功，跳过下一条规则（即 `pam_faillock.so authfail`），继续执行后续规则。
    * `nullok` 允许空密码。
2. **​`auth [default=die] pam_faillock.so authfail`​**：

    * 如果前面的 `pam_unix.so` 失败，执行这条规则。`default=die` 表示如果 `pam_faillock.so authfail` 失败，立即终止认证流程。
3. **​`auth sufficient pam_faillock.so authsucc`​**：

    * 如果 `pam_faillock.so authsucc` 成功，则认证成功，不再执行后续规则。
4. **​`auth requisite pam_deny.so`​**：

    * 如果执行到这条规则，认证将被拒绝。`requisite` 表示如果这条规则失败，立即终止认证流程。
5. **​`auth required pam_permit.so`​**：

    * 这条规则总是成功，通常用于确保至少有一个成功的规则。
6. **​`auth optional pam_cap.so`​**：

    * 这是一个可选模块，用于处理 Linux 能力（capabilities），不影响认证结果。

## 运行脚本
```shell
chmod +x config_update.sh
./config_update.sh
```

![1JU%XPNJB7K0T0(MUVXHT7L](https://github.com/user-attachments/assets/984365bb-67e9-496a-88b6-4c5b4a3b29ab)
