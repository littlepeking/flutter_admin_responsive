/*******************************************************************************
 *                                     NOTICE
 *
 *             THIS SOFTWARE IS THE PROPERTY OF AND CONTAINS
 *             CONFIDENTIAL INFORMATION OF Shanghai Enhantec Information
 *             Technology Co., Ltd. AND SHALL NOT BE DISCLOSED WITHOUT PRIOR
 *             WRITTEN PERMISSION. LICENSED CUSTOMERS MAY COPY AND
 *             ADAPT THIS SOFTWARE FOR THEIR OWN USE IN ACCORDANCE WITH
 *             THE TERMS OF THEIR SOFTWARE LICENSE AGREEMENT.
 *             ALL OTHER RIGHTS RESERVED.
 *
 *             (c) COPYRIGHT 2022 Enhantec. ALL RIGHTS RESERVED.
 *
 *******************************************************************************/

///Author: John Wang
///john.wang_ca@hotmail.com

Map<String, String> baseZhCNMessages = {
  //test i18 data
  'popUp': '弹出框',
  'checkBox': '选择框',

  'customerId': '客户代码',
  'Please Select Supplier': '请选择供应商',
  'Validate Form': '校验表单',
  'Show Grid Filters': '显示查询条件',
  'Show Selected Rows': '显示选中数据',

  //module

  'common.module.workbench': '工作台',
  'common.module.system': '系统管理',

  //error

  'common.error.internalServerError': '内部服务器错误，请联系管理员',
  'common.error.neworkError': '网络连接错误',
  'common.error.systemError': '系统错误',
  'common.error.urlNotFound': '请求的服务器地址不存在',
  'common.error.codeNotFound': '未找到代码',
  'common.error.fieldNotEmpty': '字段不能为空',
  'common.error.noRecordRelated2Code': '未找到关联的代码',
  'common.error.multiRecordsRelated2Code': '多个记录关联到代码',

  //security

  'common.security.security': '安全',
  'common.security.signIn': '登录',
  'common.security.logout': '退出',
  'common.security.loginExpired': '用户会话已过期',
  'common.security.badCredentials': '用户名密码错误',
  'common.security.usernameOrPasswordEmpty': '用户名密码不能为空',
  'common.security.unauthorized': '用户无权访问该功能',
  'common.security.username': '用户名',
  'common.security.password': '密码',
  'common.security.organization': '组织',
  'common.security.user': '用户',
  'common.security.role': '角色',
  'common.security.permission': '权限',
  'common.security.funcPerms': '功能权限',
  'common.security.roleName': '角色名称',
  'common.security.authorityCode': '权限代码',
  'common.security.domainUsername': '域用户名',
  'common.security.authType': '认证类型',
  'common.security.accountLocked': '账户是否锁定',
  'common.security.credentialsExpired': '密码是否过期',
  'common.security.originalPassword': '原密码',
  'common.security.newPassword': '新密码',
  'common.security.verifyNewPassword': '重复新密码',
  'common.security.assignedRoles': '已分配的角色',
  'common.security.assign': '授予',
  'common.security.userList': '用户列表',
  'common.security.assignRole': '角色授予',
  'common.security.roleList': '角色列表',
  'common.security.revokeRoles': '移除角色',
  'common.security.organizations': '组织',
  'common.security.orgName': '组织名称',
  'common.security.parentOrg': '父级组织',
  'common.security.organizationCode': '组织代码',
  'common.security.address1': '地址1',
  'common.security.address2': '地址2',
  'common.security.contact1': '联系人1',
  'common.security.contact2': '联系人2',
  'common.security.passwordNotMatch': '密码不匹配',
  'common.security.firstName': '名字',
  'common.security.lastName': '姓',
  'common.security.userRoleAuthorization': '用户角色授权',
  'common.security.selectOrg': '请选择一个组织',
  'common.security.selectOrgDefaultVal': '<请选择组织>',
  'common.security.selectOrgBeforeCreatePerm': '请为新建权限选择一个目录',
  'common.security.userSaved': '用户 @username 保存成功',
  'common.security.roleAssigned2User': '角色 @displayName 成功授予用户 @username',
  'common.security.roleRevokedFromUser': '角色 @displayName 已成功从用户 @username 收回',
  'common.security.roleSaved': '角色 @displayName 保存成功',
  'common.security.roleDeleted': '角色 @displayName 删除成功',
  'common.security.selectOrgBeforeAddRole': '请在创建角色前先选择一个组织',
  'common.security.deleteRole': '删除角色',
  'common.security.selectedUsersDeleted': '选中的用户删除成功',

  //general

  'common.general.id': '序号',
  'common.general.description': '描述',
  'common.general.all': '[全部]',
  'common.general.yes': '是',
  'common.general.no': '否',
  'common.general.save': '保存',
  'common.general.quit': '退出',
  'common.general.print': '打印',
  'common.general.actions': '执行',
  'common.general.changeLocale': '切换语言',
  'common.general.changeTheme': '切换主题',
  'common.general.notification': '通知',
  'common.general.alert': '警告',
  'common.general.configuration': '配置',
  'common.general.report': '报表',
  'common.general.welcome': '欢迎使用殷汉 - @System',
  'common.general.scmExecutionPlatform': '供应链执行平台',
  'common.general.saved': '保存成功',
  'common.general.deleted': '删除成功',
  'common.general.add': '新建',
  'common.general.edit': '编辑',
  'common.general.delete': '删除',
  'common.general.displayName': '显示名称',
  'common.general.code': '代码',
  'common.general.type': '类型',
  'common.general.other': '其他',
  'common.general.messageInfo': '系统消息',
  'common.general.isEnabled': '是否启用',
  'common.general.generalInfo': '基本信息',
  'common.general.detailInfo': '详细信息',
  'common.general.summaryInfo': '汇总信息',
  'common.general.filterCondition': '',
  'common.general.name': '名称',
  'common.general.city': '城市',
  'common.general.close': '关闭',
  'common.general.qty': '数量',
  'common.general.date': '日期',
  'common.general.time': '时间',
  'common.general.confirm': '确认',
  'common.general.cancel': '取消',
  'common.general.blank': '[空]',
  'common.general.addWho': '添加人',
  'common.general.editWho': '修改人',
  'common.general.addDate': '添加日期',
  'common.general.editDate': '修改日期',
  'common.general.directory': '目录',
  'common.general.dateFormatInfo': '日期格式为:',
  'common.general.use24HoursFormat': '24小时制',
  'common.general.selectDate': '请选择日期',
  'common.general.selectDateFirst': '请先选择日期',
  'common.general.selectItem': '请选择条目',
  'common.general.loading': '加载中....',
  'common.general.windowCannotEmpty': '窗口列表为空',
  'common.general.windowList': '窗口列表',
  'common.general.Export2Excel': '导出为EXCEL',
  'common.general.page': '页',
  'common.general.rowPerPage': '每页行数',
};
