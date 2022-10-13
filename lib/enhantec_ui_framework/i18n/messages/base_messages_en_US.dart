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

Map<String, String> baseEnUSMessages = {
  //module

  'common.module.workbench': 'WorkBench',
  'common.module.system': 'System',

  'common.module.wms': 'WMS',
  'common.module.tms': 'TMS',

  //error

  'common.error.internalServerError':
      'Internal server error, please contact admin',
  'common.error.neworkError': 'Network connect error',
  'common.error.systemError': 'System Error',
  'common.error.fieldNotEmpty': 'This field cannot be empty',
  'common.error.urlNotFound': 'request url cannot found',
  'common.error.codeNotFound': 'The code cannot be found',
  'common.error.noRecordRelated2Code': 'No record related to code',
  'common.error.multiRecordsRelated2Code': 'Mutilple records related to code',

  //security

  'common.security.security': 'Security',
  'common.security.signIn': 'Sign In',
  'common.security.logout': 'Logout',
  'common.security.loginExpired': 'user login is expired.',
  'common.security.badCredentials': 'Bad credentials',
  'common.security.usernameOrPasswordEmpty':
      'username and password cannot be empty',
  'common.security.unauthorized': 'Unauthorized',
  'common.security.username': 'Username',
  'common.security.password': 'Password',
  'common.security.organization': 'Organization',
  'common.security.user': 'User',
  'common.security.role': 'Role',
  'common.security.permission': 'Permission',
  'common.security.funcPerms': 'Permissions',
  'common.security.roleName': 'Role Name',
  'common.security.authorityCode': 'Authority Code',
  'common.security.domainUsername': 'Domain Username',
  'common.security.authType': 'Auth Type',
  'common.security.accountLocked': 'Account Locked',
  'common.security.credentialsExpired': 'Credentials Expired',
  'common.security.originalPassword': 'Original Password',
  'common.security.newPassword': 'New Password',
  'common.security.verifyNewPassword': 'Verify New Password',
  'common.security.assignedRoles': 'Assigned Roles',
  'common.security.assign': 'Assign',
  'common.security.userList': 'User List',
  'common.security.assignRole': 'Assign Role',
  'common.security.roleList': 'Role List',
  'common.security.revokeRoles': 'Revoke Roles',
  'common.security.organizations': 'Organizations',
  'common.security.orgName': 'Organization Name',
  'common.security.parentOrg': 'Parent Organization',
  'common.security.organizationCode': 'Organization Code',
  'common.security.address1': 'Address1',
  'common.security.address2': 'Address2',
  'common.security.contact1': 'Contact1',
  'common.security.contact2': 'Contact2',
  'common.security.passwordNotMatch': 'Password does not match',
  'common.security.firstName': 'First Name',
  'common.security.lastName': 'Last Name',
  'common.security.userRoleAuthorization': 'User role authorization',
  'common.security.selectOrg': 'Please select an organization',
  'common.security.selectOrgDefaultVal': '<Select Org>',
  'common.security.selectOrgBeforeCreatePerm':
      'Please select a directory before creating a permission',
  'common.security.userSaved': 'User @username saved',
  'common.security.roleAssigned2User':
      'Role @displayName assigned to user @username successfully',
  'common.security.roleRevokedFromUser':
      'Role @displayName revoked from user @username successfully',
  'common.security.roleSaved': 'Role @displayName saved',
  'common.security.deleteRole': 'Delete Role',
  'common.security.roleDeleted': 'Role @displayName deleted',
  'common.security.selectOrgBeforeAddRole':
      'Please select an organization before add a role',

  'common.security.selectedUsersDeleted': 'Selected users deleted',

  //general

  'common.general.id': 'ID',
  'common.general.description': 'Description',
  'common.general.all': '[--All--]',
  'common.general.yes': 'Yes',
  'common.general.no': 'No',
  'common.general.save': 'Save',
  'common.general.quit': 'Quit',
  'common.general.print': 'Print',
  'common.general.actions': 'Actions',
  'common.general.changeLocale': 'Change Language',
  'common.general.changeTheme': 'Change Theme',
  'common.general.notification': 'Notifications',
  'common.general.alert': 'Alerts',
  'common.general.configuration': 'Configuration',
  'common.general.report': 'Reports',
  'common.general.welcome': '@System Welcome Page',
  'common.general.scmExecutionPlatform': 'SCM Execution Platform',
  'common.general.saved': 'Saved successfully',
  'common.general.deleted': 'Deleted successfully',
  'common.general.add': 'Add',
  'common.general.edit': 'Edit',
  'common.general.delete': 'Delete',
  'common.general.displayName': 'Display Name',
  'common.general.code': 'Code',
  'common.general.type': 'Type',
  'common.general.other': 'Other',
  'common.general.messageInfo': 'Message Infomation',
  'common.general.isEnabled': 'Enabled',
  'common.general.generalInfo': 'General Info',
  'common.general.detailInfo': 'Detail Info',
  'common.general.summaryInfo': 'Summary Info',
  'common.general.filterCondition': 'Filter...',
  'common.general.name': 'name',
  'common.general.city': 'City',
  'common.general.close': 'Close',
  'common.general.qty': 'Quantity',
  'common.general.Date': 'Date',
  'common.general.time': 'Time',
  'common.general.confirm': 'Confirm',
  'common.general.cancel': 'Cancel',
  'common.general.blank': '[Blank]',
  'common.general.addWho': 'Add Who',
  'common.general.editWho': 'Edit Who',
  'common.general.addDate': 'Add Date',
  'common.general.editDate': 'Edit Date',
  'common.general.directory': 'Directory',
  'common.general.dateFormatInfo': 'Date format should be: ',
  'common.general.use24HoursFormat': 'Use 24 hours',
  'common.general.selectDate': 'Please Select Date',
  'common.general.selectDateFirst': 'Please select a date firstly',
  'common.general.selectItem': 'Please Select Item',
  'common.general.loading': 'Loading....',
  'common.general.windowCannotEmpty': 'Window list is empty',
  'common.general.windowList': 'Window List',
  'common.general.Export2Excel': 'Export to EXCEL',
  'common.general.page': 'Page',
  'common.general.rowPerPage': 'Rows / Page',
};
