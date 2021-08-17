USE pistonint_cloud;

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `sys_dept`;
create table sys_dept
(
    dept_id     int(20) auto_increment
        primary key,
    name        varchar(50) null comment '部门名称',
    sort        int null comment '排序',
    create_time timestamp default CURRENT_TIMESTAMP null comment '创建时间',
    update_time timestamp null on update CURRENT_TIMESTAMP comment '修改时间',
    del_flag    char      default '0' null comment '是否删除  -1：已删除  0：正常',
    parent_id   int null,
    tenant_id   int null,
    enable      tinyint(1) default 1 null comment '是否可用',
    constraint sys_dept_name_uq_index
        unique (name, tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='部门管理';

BEGIN;
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (1, '山东农信', null, '2018-01-22 19:00:23', '2021-02-01 12:06:11', '0', -1, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (2, '沙县国际', null, '2018-01-22 19:00:38', '2021-02-01 12:06:15', '0', -1, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (3, '潍坊农信', null, '2018-01-22 19:00:44', '2021-01-29 22:56:08', '0', 1, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (4, '高新农信', null, '2018-01-22 19:00:52', '2021-01-29 22:56:09', '0', 3, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (5, '院校农信', null, '2018-01-22 19:00:57', '2021-01-29 22:56:10', '0', 4, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (6, '潍院农信', null, '2018-01-22 19:01:06', '2021-01-29 22:56:11', '1', 5, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (7, '山东沙县', null, '2018-01-22 19:01:57', '2021-01-29 22:56:12', '0', 2, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (8, '潍坊沙县', null, '2018-01-22 19:02:03', '2021-01-29 22:56:13', '0', 7, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (9, '高新沙县', null, '2018-01-22 19:02:14', '2021-01-29 22:56:14', '1', 8, 1, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (10, '优车库', null, '2018-11-18 13:27:11', '2021-02-23 23:52:18', '0', -1, 2, 1);
INSERT INTO sys_dept (dept_id, name, sort, create_time, update_time, del_flag, parent_id, tenant_id, enable)
VALUES (11, '院校沙县', null, '2018-12-10 21:19:26', '2021-01-29 22:56:16', '0', 8, 1, 1);
COMMIT;

DROP TABLE IF EXISTS `sys_dept_role`;
create table sys_dept_role
(
    role_id int not null comment '用户ID',
    dept_id int not null comment '角色ID',
    primary key (role_id, dept_id)
)
    comment '用户角色表' charset = utf8;
BEGIN;
INSERT INTO sys_dept_role (role_id, dept_id) VALUES (1, 1);
INSERT INTO sys_dept_role (role_id, dept_id) VALUES (2, 2);
COMMIT;

DROP TABLE IF EXISTS `sys_dept_relation`;
CREATE TABLE `sys_dept_relation`
(
    `ancestor`   int(11) NOT NULL COMMENT '祖先节点',
    `descendant` int(11) NOT NULL COMMENT '后代节点',
    PRIMARY KEY (`ancestor`, `descendant`) USING BTREE,
    KEY          `idx1` (`ancestor`) USING BTREE,
    KEY          `idx2` (`descendant`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC COMMENT='部门关系表';

BEGIN;
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (1, 1);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (1, 3);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (1, 4);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (1, 5);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (2, 2);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (2, 7);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (2, 8);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (2, 11);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (3, 3);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (3, 4);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (3, 5);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (4, 4);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (4, 5);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (5, 5);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (7, 7);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (7, 8);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (7, 11);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (8, 8);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (8, 11);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (10, 10);
INSERT INTO sys_dept_relation (ancestor, descendant)
VALUES (11, 11);
COMMIT;

DROP TABLE IF EXISTS sys_dict;
create table sys_dict
(
    id          int(64) auto_increment comment '编号'
        primary key,
    type        varchar(100)                        not null comment '类型',
    description varchar(100)                        not null comment '描述',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    remarks     varchar(255) null comment '备注信息',
    `system`    char      default '0'               not null comment '0-否|1-是',
    del_flag    char      default '0'               not null comment '删除标记',
    tenant_id   int       default 0                 not null comment '所属租户',
    KEY         `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典表';

BEGIN;
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (1, 'log_type', '日志类型', '2019-03-19 11:06:44', '2019-03-19 11:06:44', '异常、正常', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (2, 'social_type', '社交登录', '2019-03-19 11:09:44', '2019-03-19 11:09:44', '微信、QQ', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (3, 'leave_status', '请假状态', '2019-03-19 11:09:44', '2019-03-19 11:09:44', '未提交、审批中、完成、驳回', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (4, 'job_type', '定时任务类型', '2019-03-19 11:22:21', '2019-03-19 11:22:21', 'quartz', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (5, 'job_status', '定时任务状态', '2019-03-19 11:24:57', '2019-03-19 11:24:57', '发布状态、运行状态', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (6, 'job_execute_status', '定时任务执行状态', '2019-03-19 11:26:15', '2019-03-19 11:26:15', '正常、异常', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (7, 'misfire_policy', '定时任务错失执行策略', '2019-03-19 11:27:19', '2019-03-19 11:27:19', '周期', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (8, 'gender', '性别', '2019-03-27 13:44:06', '2019-03-27 13:44:06', '微信用户性别', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (9, 'subscribe', '订阅状态', '2019-03-27 13:48:33', '2019-03-27 13:48:33', '公众号订阅状态', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (10, 'response_type', '回复', '2019-03-28 21:29:21', '2019-03-28 21:29:21', '微信消息是否已回复', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (11, 'param_type', '参数配置', '2019-04-29 18:20:47', '2019-04-29 18:20:47', '检索、原文、报表、安全、文档、消息、其他', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (12, 'tenant_status_type', '租户状态', '2019-05-15 16:31:08', '2019-05-15 16:31:08', '租户状态', '1', '0', 1);
INSERT INTO sys_dict (id, type, description, create_time, update_time, remarks, `system`, del_flag, tenant_id)
VALUES (13, 'dict_type', '字典类型', '2019-05-16 14:16:20', '2019-05-16 14:20:16', '系统类不能修改', '1', '0', 1);
COMMIT;

DROP TABLE IF EXISTS sys_dict_item;
create table sys_dict_item
(
    id          int(64) auto_increment comment '编号'
        primary key,
    dict_id     int                                 not null,
    value       varchar(100)                        not null comment '数据值',
    label       varchar(100)                        not null comment '标签名',
    type        varchar(100)                        not null comment '类型',
    description varchar(100)                        not null comment '描述',
    sort        int(10) not null comment '排序（升序）',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    remarks     varchar(255) null comment '备注信息',
    del_flag    char      default '0'               not null comment '删除标记',
    tenant_id   int       default 0                 not null comment '所属租户',
    KEY `sys_dict_value` (`value`) USING BTREE,
    KEY `sys_dict_label` (`label`) USING BTREE,
    KEY `sys_dict_del_flag` (`del_flag`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典项';

BEGIN;
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (1, 1, '9', '异常', 'log_type', '日志异常', 1, '2019-03-19 11:08:59', '2019-03-25 12:49:13', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (2, 1, '0', '正常', 'log_type', '日志正常', 0, '2019-03-19 11:09:17', '2019-03-25 12:49:18', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (3, 2, 'WX', '微信', 'social_type', '微信登录', 0, '2019-03-19 11:10:02', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (4, 2, 'QQ', 'QQ', 'social_type', 'QQ登录', 1, '2019-03-19 11:10:14', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (5, 3, '0', '未提交', 'leave_status', '未提交', 0, '2019-03-19 11:18:34', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (6, 3, '1', '审批中', 'leave_status', '审批中', 1, '2019-03-19 11:18:45', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (7, 3, '2', '完成', 'leave_status', '完成', 2, '2019-03-19 11:19:02', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (8, 3, '9', '驳回', 'leave_status', '驳回', 9, '2019-03-19 11:19:20', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (9, 4, '1', 'java类', 'job_type', 'java类', 1, '2019-03-19 11:22:37', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (10, 4, '2', 'spring bean', 'job_type', 'spring bean容器实例', 2, '2019-03-19 11:23:05', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (11, 4, '9', '其他', 'job_type', '其他类型', 9, '2019-03-19 11:23:31', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (12, 4, '3', 'Rest 调用', 'job_type', 'Rest 调用', 3, '2019-03-19 11:23:57', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (13, 4, '4', 'jar', 'job_type', 'jar类型', 4, '2019-03-19 11:24:20', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (14, 5, '1', '未发布', 'job_status', '未发布', 1, '2019-03-19 11:25:18', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (15, 5, '2', '运行中', 'job_status', '运行中', 2, '2019-03-19 11:25:31', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (16, 5, '3', '暂停', 'job_status', '暂停', 3, '2019-03-19 11:25:42', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (17, 6, '0', '正常', 'job_execute_status', '正常', 0, '2019-03-19 11:26:27', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (18, 6, '1', '异常', 'job_execute_status', '异常', 1, '2019-03-19 11:26:41', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (19, 7, '1', '错失周期立即执行', 'misfire_policy', '错失周期立即执行', 1, '2019-03-19 11:27:45', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (20, 7, '2', '错失周期执行一次', 'misfire_policy', '错失周期执行一次', 2, '2019-03-19 11:27:57', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (21, 7, '3', '下周期执行', 'misfire_policy', '下周期执行', 3, '2019-03-19 11:28:08', '2019-03-25 12:49:36', '', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (22, 8, '1', '男', 'gender', '微信-男', 0, '2019-03-27 13:45:13', '2019-03-27 13:45:13', '微信-男', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (23, 8, '2', '女', 'gender', '女-微信', 1, '2019-03-27 13:45:34', '2019-03-27 13:45:34', '女-微信', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (24, 8, '0', '未知', 'gender', 'x性别未知', 3, '2019-03-27 13:45:57', '2019-03-27 13:45:57', 'x性别未知', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (25, 9, '0', '未关注', 'subscribe', '公众号-未关注', 0, '2019-03-27 13:49:07', '2019-03-27 13:49:07', '公众号-未关注', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (26, 9, '1', '已关注', 'subscribe', '公众号-已关注', 1, '2019-03-27 13:49:26', '2019-03-27 13:49:26', '公众号-已关注', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (27, 10, '0', '未回复', 'response_type', '微信消息-未回复', 0, '2019-03-28 21:29:47', '2019-03-28 21:29:47', '微信消息-未回复', '0', 1);
INSERT INTO sys_dict_item (id, dict_id, value, label, type, description, sort, create_time, update_time, remarks, del_flag, tenant_id) VALUES (28, 10, '1', '已回复', 'response_type', '微信消息-已回复', 1, '2019-03-28 21:30:08', '2019-03-28 21:30:08', '微信消息-已回复', '0', 1);
COMMIT;

DROP TABLE IF EXISTS sys_menu;
create table sys_menu
(
    menu_id     int                                  not null comment '菜单ID'
        primary key,
    name        varchar(32)                          not null comment '菜单名称',
    permission  varchar(32)                          not null comment '菜单权限标识',
    path        varchar(128)                         null comment '前端URL',
    http_method varchar(10)                          null comment 'http请求方法',
    parent_id   int                                  null comment '父菜单ID',
    icon        varchar(32)                          null comment '图标',
    component   varchar(64)                          null comment 'VUE页面',
    sort        int        default 1                 null comment '排序值',
    keep_alive  char       default '0'               null comment '0-开启，1- 关闭',
    type        char                                 null comment '菜单类型 （0菜单 1按钮）',
    create_time timestamp  default CURRENT_TIMESTAMP null comment '创建时间',
    update_time timestamp                            null on update CURRENT_TIMESTAMP comment '更新时间',
    del_flag    char       default '0'               null comment '逻辑删除标记(0--正常 1--删除)',
    `show`      tinyint(1) default 1                 null,
    constraint permission_uq_index
        unique (permission)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单表';

BEGIN;
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1000, '权限管理', 'permission_mgmt', '/upms', null, -1, 'icon-quanxianguanli', 'Layout', 0, '0', '0', '2018-09-28 08:29:53', '2021-02-06 18:41:58', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1100, '用户管理', 'user_mgmt', 'user', null, 1000, 'icon-yonghuguanli', 'views/admin/user/index', 1, '1', '0', '2017-11-02 22:24:37', '2021-02-06 18:42:02', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1101, '用户新增', 'sys_user_add', '/user', 'post', 1100, null, null, null, '0', '1', '2017-11-08 09:52:09', '2021-02-06 22:40:45', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1102, '用户修改', 'sys_user_edit', '/user', 'put', 1100, null, null, null, '0', '1', '2017-11-08 09:52:48', '2021-02-06 22:40:50', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1103, '用户删除', 'sys_user_del', '/user/{id}', 'delete', 1100, null, null, null, '0', '1', '2017-11-08 09:54:01', '2021-02-06 22:40:56', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1104, '获取当前用户全部信息', 'sys_user_info', '/user/info', 'get', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1105, '获取指定用户全部信息', 'sys_user_get_by_name', '/user/info/{username}', 'get', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1106, '通过ID查询用户信息', 'sys_user_get_by_id', '/user/info/{id}', 'get', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1107, '根据用户名查询用户详细信息', 'sys_user_detail', '/user/details/{username}', 'get', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1108, '用户注册', 'sys_user_register', '/user/register', 'post', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1109, '分页查询用户', 'sys_user_page', '/user/page', 'get', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1110, '根据id批量查询用户', 'sys_user_list', '/user/list', 'post', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', '2021-02-07 08:42:54', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1111, '修改用户信息', 'sys_user_update', '/user/edit', 'put', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1112, '查询上级部门的用户信息', 'sys_user_ancestor', '/user/ancestor/{username}', 'get', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1113, '根据手机号码创建临时账号', 'sys_user_temporary_mobile', '/user/temporary/mobile/{mobile}', 'post', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1114, '根据邮箱号码创建临时账号', 'sys_user_temporary_email', '/user/temporary/email/{email}', 'post', 1100, null, null, 11, '0', '1', '2021-02-07 00:54:21', '2021-02-07 16:11:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1200, '菜单管理', 'menu_mgmt', 'menu', null, 1000, 'icon-caidanguanli', 'views/admin/menu/index', 2, '0', '0', '2017-11-08 09:57:27', '2021-02-06 18:42:05', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1201, '菜单新增', 'sys_menu_add', '/menu', 'post', 1200, null, null, null, '0', '1', '2017-11-08 10:15:53', '2021-02-06 23:03:23', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1202, '菜单修改', 'sys_menu_edit', '/menu', 'put', 1200, null, null, null, '0', '1', '2017-11-08 10:16:23', '2021-02-06 23:03:42', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1203, '菜单删除', 'sys_menu_del', '/menu/{id}', 'delete', 1200, null, null, null, '0', '1', '2017-11-08 10:16:43', '2021-02-06 23:50:14', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1204, '返回当前用户的树形菜单集合', 'sys_user_menu', 'menu', 'get', 1200, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1205, '返回树形菜单集合', 'sys_menu_tree', '/menu/tree', 'get', 1200, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1206, '返回角色的菜单集合', 'sys_role_menu_tree', '/menu/tree/{roleId}', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1207, '通过ID查询菜单的详细信息', 'sys_menu_get_by_id', '/menu/id', 'get', 1200, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1300, '角色管理', 'role_mgmt', 'role', null, 1000, 'icon-jiaoseguanli', 'views/admin/role/index', 3, '0', '0', '2017-11-08 10:13:37', '2021-02-06 18:42:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1301, '角色新增', 'sys_role_add', '/role', 'post', 1300, null, null, null, '0', '1', '2017-11-08 10:14:18', '2021-02-06 23:50:21', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1302, '角色修改', 'sys_role_edit', '/role', 'put', 1300, null, null, null, '0', '1', '2017-11-08 10:14:41', '2021-02-06 23:50:30', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1303, '角色删除', 'sys_role_del', '/role/{id}', 'delete', 1300, null, null, null, '0', '1', '2017-11-08 10:14:59', '2021-02-06 23:50:54', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1304, '分配权限', 'sys_role_perm', null, null, 1300, null, null, null, '0', '1', '2018-04-20 07:22:55', '2018-09-28 09:13:23', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1305, '通过ID查询角色信息', 'sys_role_get_by_id', '/role/{id}', 'get', 1300, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1306, '通过ID查询角色详细信息', 'sys_role_detail', '/role/{id}/detail', 'get', 1300, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1307, '获取角色列表', 'sys_role_list', '/role/list', 'post', 1300, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1308, '更新角色菜单', 'sys_role_menu_edit', '/role/menu', 'put', 1300, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1400, '部门管理', 'dept_mgmt', 'dept', null, 1000, 'icon-web-icon-', 'views/admin/dept/index', 4, '0', '0', '2018-01-20 13:17:19', '2021-02-06 18:42:16', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1401, '部门新增', 'sys_dept_add', '/dept', 'post', 1400, null, null, null, '0', '1', '2018-01-20 14:56:16', '2021-02-06 23:50:59', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1402, '部门修改', 'sys_dept_edit', '/dept', 'put', 1400, null, null, null, '0', '1', '2018-01-20 14:56:59', '2021-02-06 23:52:02', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1403, '部门删除', 'sys_dept_del', '/dept/{id}', 'delete', 1400, null, null, null, '0', '1', '2018-01-20 14:57:28', '2021-02-06 23:52:18', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1404, '通过ID查询部门', 'sys_dept_get_by_id', '/dept/{id}', 'get', 1400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1405, '分页查询部门信息', 'sys_dept_page', '/dept/page', 'get', 1400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1406, '返回树形部门列表', 'sys_dept_tree', '/dept/tree', 'get', 1400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1407, '获取某个部门所有用户', 'sys_dept_users', '/dept/{deptId}/users', 'get', 1400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1408, '获取子部门id', 'sys_dept_child_id_list', '/dept/{deptId}/child', 'get', 1400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1500, '租户管理', 'tenant_mgmt', 'tenant', null, 1000, 'icon-guiji', 'views/admin/tenant/index', 5, '0', '0', '2021-02-07 15:14:33', '2021-02-07 16:32:38', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1501, '分页查询租户信息', 'sys_tenant_page', '/tenant/page', 'get', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1502, '通过id查询租户', 'sys_tenant_get_by_id', '/tenant/{id}', 'get', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1503, '通过id查询租户详细信息', 'sys_tenant_detail', '/tenant/detail/{id}', 'get', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1504, '新增租户', 'sys_tenant_add', '/tenant', 'post', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1505, '修改租户', 'sys_tenant_edit', '/tenant', 'put', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1506, '查询租户下面所有部门', 'sys_tenant_dept', '/tenant/{id}/dept', 'get', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (1507, '查询全部有效的租户', 'sys_tenant_list', '/tenant/list', 'get', 1500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2000, '系统管理', 'sys_mgmt', '/admin', null, -1, 'icon-xitongguanli', 'Layout', 1, '0', '0', '2017-11-07 20:56:00', '2021-02-06 18:42:21', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2100, '日志管理', 'log_mgmt', 'log', null, 2000, 'icon-rizhiguanli', 'views/admin/log/index', 5, '0', '0', '2017-11-20 14:06:22', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2101, '日志删除', 'sys_log_del', '/log/{id}', 'delete', 2100, null, null, null, '0', '1', '2017-11-20 20:37:37', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2102, '通过ID查询字典信息', 'sys_dict_get_by_id', '/dict/{id}', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2103, '分页查询字典信息', 'sys_dict_page', '/dict/page', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2104, '通过字典类型查找字典', 'sys_dict_list', '/dict/type/{type}', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2105, '通过字典类型,类型值查找字典', 'sys_dict_get_value_by_type', '/dict/type/{type}/{value}', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2106, '分页查询字典项', 'sys_dict_item_page', '/dict/item/page', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2107, '通过id查询字典项', 'sys_dict_item_get_by_id', '/dict/item/{id}', 'get', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2108, '新增字典项', 'sys_dict_item_add', '/dict/item', 'post', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2109, '修改字典项', 'sys_dict_item_edit', '/dict/item', 'put', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2110, '删除字典项', 'sys_dict_item_delete', '/dict/item/{id}', 'delete', 2100, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2200, '字典管理', 'dict_mgmt', 'dict', null, 2000, 'icon-navicon-zdgl', 'views/admin/dict/index', 6, '0', '0', '2017-11-29 11:30:52', '2021-02-06 18:42:32', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2201, '字典删除', 'sys_dict_del', '/dict/{id}', 'delete', 2200, null, null, null, '0', '1', '2017-11-29 11:30:11', '2021-02-06 23:53:06', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2202, '字典新增', 'sys_dict_add', '/dict', 'post', 2200, null, null, null, '0', '1', '2018-05-11 22:34:55', '2021-02-06 23:53:24', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2203, '字典修改', 'sys_dict_edit', '/dict', 'put', 2200, null, null, null, '0', '1', '2018-05-11 22:36:03', '2021-02-06 23:53:46', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2210, '参数管理', 'sys_public_param_mgmt', 'param', null, 2000, 'icon-canshu', 'views/admin/param/index', 7, '0', '0', '2021-02-07 14:14:24', '2021-02-07 16:51:28', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2211, '参数新增', 'sys_public_param_add', '/param', 'post', 2210, null, null, 1, '0', '1', '2021-02-07 14:14:24', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2212, '参数删除', 'sys_public_param_del', '/param/{publicId}', 'delete', 2210, null, null, 1, '0', '1', '2021-02-07 14:14:24', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2213, '参数编辑', 'sys_public_param_edit', '/param', 'put', 2210, null, null, 1, '0', '1', '2021-02-07 14:14:24', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2214, '通过key查询公共参数值', 'sys_public_param_get_val', '/param/public-value/{publicKey}', 'get', 2210, null, null, 1, '0', '1', '2021-02-07 14:14:24', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2215, '分页查询', 'sys_public_param_page', '/param/page', 'get', 2210, null, null, 1, '0', '1', '2021-02-07 14:14:24', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2216, '通过id查询公共参数', 'sys_public_param_get_by_id', '/param/{publicId}', 'get', 2210, null, null, 1, '0', '1', '2021-02-07 14:14:24', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2300, '代码生成', 'gen_code_mgmt', 'gen', null, 2000, 'icon-weibiaoti46', 'views/gen/index', 8, '0', '0', '2018-01-20 13:17:19', '2021-02-07 14:14:28', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2400, '终端管理', 'oauth2_client_mgmt', 'client', null, 2000, 'icon-shouji', 'views/admin/client/index', 9, '0', '0', '2018-01-20 13:17:19', '2021-02-06 18:42:57', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2401, '客户端新增', 'sys_client_add', '/client', 'post', 2400, '1', null, null, '0', '1', '2018-05-15 21:35:18', '2021-02-06 23:54:13', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2402, '客户端修改', 'sys_client_edit', '/client', 'put', 2400, null, null, null, '0', '1', '2018-05-15 21:37:06', '2021-02-06 23:54:25', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2403, '客户端删除', 'sys_client_del', '/client/{id}', 'delete', 2400, null, null, null, '0', '1', '2018-05-15 21:39:16', '2021-02-06 23:54:42', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2404, '通过ID查询终端', 'sys_client_get_by_id', '/client/{id}', 'get', 2400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2405, '分页查询终端', 'sys_client_page', '/client/page', 'get', 2400, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2500, '密钥管理', 'secret_key_mgmt', 'social', null, 2000, 'icon-miyue', 'views/admin/social/index', 10, '0', '0', '2018-01-20 13:17:19', '2021-02-06 18:43:47', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2501, '密钥新增', 'sys_social_details_add', '/social', 'post', 2500, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-06 23:55:58', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2502, '密钥修改', 'sys_social_details_edit', '/social', 'put', 2500, '1', null, 1, '0', '1', '2018-05-15 21:35:18', '2021-02-06 23:56:04', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2503, '密钥删除', 'sys_social_details_del', '/social', 'delete', 2500, '1', null, 2, '0', '1', '2018-05-15 21:35:18', '2021-02-06 23:56:35', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2504, '社交登录账户简单分页查询', 'sys_social_page', '/social/{id}', 'get', 2500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2505, '通过ID查询社交登录账户信息', 'sys_social_get_by_id', '/social/{id}', 'get', 2500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2506, '通过社交账号、手机号查询用户、角色信息', 'sys_social_info', '/social/info/{type}', 'get', 2500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2507, '绑定社交账号', 'sys_social_bind', '/social/bind', 'post', 2500, null, null, 11, '0', '1', '2021-02-07 00:54:21', null, '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2600, '令牌管理', 'token_mgmt', 'token', null, 2000, 'icon-denglvlingpai', 'views/admin/token/index', 11, '0', '0', '2018-09-04 05:58:41', '2021-02-06 18:43:51', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2601, '令牌删除', 'sys_token_del', null, 'delete', 2600, null, null, 1, '0', '1', '2018-09-04 05:59:50', '2021-02-07 00:55:47', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2700, '动态路由', 'route_mgmt', 'route', null, 2000, 'icon-luyou', 'views/admin/route/index', 12, '0', '0', '2018-09-04 05:58:41', '2021-02-06 18:44:00', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2800, 'Quartz管理', 'job_mgmt', 'job-manage', null, 2000, 'icon-guanwangfangwen', 'views/daemon/job-manage/index', 8, '0', '0', '2018-01-20 13:17:19', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2810, '任务新增', 'job_sys_job_add', null, 'post', 2800, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2820, '任务修改', 'job_sys_job_edit', null, 'put', 2800, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2830, '任务删除', 'job_sys_job_del', null, 'delete', 2800, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2840, '任务暂停', 'job_sys_job_shutdown_job', null, 'put', 2800, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2850, '任务开始', 'job_sys_job_start_job', null, null, 2800, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (2860, '任务刷新', 'job_sys_job_refresh_job', null, null, 2800, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3000, '系统监控', 'daemon_mgmt', '/daemon', null, -1, 'icon-msnui-supervise', 'Layout', 2, '0', '0', '2018-07-27 01:13:21', '2021-02-06 18:44:21', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3100, '服务监控', 'service_mgmt', 'http://120.79.140.119:11005/login', null, 3000, 'icon-server', null, 0, '0', '0', '2018-06-26 10:50:32', '2021-02-26 10:32:47', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3200, '接口文档', 'api_mgmt', 'http://120.79.140.119:11009/', null, 3000, 'icon-wendang', null, 1, '0', '0', '2018-06-26 10:50:32', '2021-02-06 18:44:37', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3300, '事务监控', 'transection_mgmt', 'tx', null, 3000, 'icon-gtsquanjushiwufuwuGTS', 'views/tx/index', 5, '0', '0', '2018-08-19 11:02:39', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3400, '在线事务', 'online_transection', 'model', null, 3000, 'icon-online', 'views/tx/model', 6, '0', '0', '2018-08-19 11:32:04', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3500, '任务监控', 'task_monitor', 'https://www.devglan.com/spring-boot/spring-boot-admin', null, 3000, 'icon-msnui-supervise', null, 7, '0', '0', '2018-06-26 10:50:32', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3600, '任务轨迹', 'task_trace', 'status-trace-log', null, 3000, 'icon-guiji', 'views/daemon/status-trace-log/index', 8, '0', '0', '2018-01-20 13:17:19', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3601, '删除轨迹', 'daemon_status_trace_log_del', null, null, 3600, '1', null, 2, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3620, 'Quartz日志', 'joblog', 'joblog', null, 3000, 'icon-gtsquanjushiwufuwuGTS', 'views/daemon/job-log/index', 8, '0', '0', '2018-01-20 13:17:19', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3630, '任务日志', 'task_log', 'execution-log', null, 3000, 'icon-wendang', 'views/daemon/execution-log/index', 7, '0', '0', '2018-01-20 13:17:19', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3631, '删除日志', 'daemon_execution_log_del', null, null, 3900, '1', null, 2, '0', '1', '2018-05-15 21:35:18', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3700, '调用拓扑', 'invoke_trace', 'https://skywalking.apache.org/', null, 3000, 'icon-line', null, 10, '0', '0', '2018-01-25 11:08:52', '2021-02-06 18:49:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (3800, '缓存状态', 'cache_mgmt', 'https://redis.io/', null, 3000, 'icon-qingchuhuancun', null, 12, '0', '0', '2018-01-23 10:56:11', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4000, '协同管理', 'act_mgmt', '/activti', null, -1, 'icon-kuaisugongzuoliu_o', 'Layout', 3, '0', '0', '2018-09-26 01:38:13', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4100, '模型管理', 'act_model_mgmt', 'activiti', null, 4000, 'icon-weibiaoti13', 'views/activiti/index', 1, '0', '0', '2018-09-26 01:39:07', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4101, '模型管理', 'act_model_manage', null, null, 4100, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2018-09-28 09:12:07', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4200, '流程管理', 'process_mgmt', 'process', null, 4000, 'icon-liucheng', 'views/activiti/process', 2, '0', '0', '2018-09-26 06:41:05', '2021-02-06 18:47:17', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4201, '流程管理', 'act_process_manage', null, null, 4200, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2018-09-28 09:12:07', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4300, '请假管理', 'level_mgmt', 'leave-bill', null, 4000, 'icon-qingjia', 'views/activiti/leave', 3, '0', '0', '2018-01-20 13:17:19', '2021-02-06 18:47:22', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4301, '请假新增', 'act_leavebill_add', null, 'post', 4300, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2021-02-07 09:28:54', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4302, '请假修改', 'act_leavebill_edit', null, 'put', 4300, '1', null, 1, '0', '1', '2018-05-15 21:35:18', '2021-02-07 09:28:50', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4303, '请假删除', 'act_leavebill_del', null, 'delete', 4300, '1', null, 2, '0', '1', '2018-05-15 21:35:18', '2021-02-07 09:28:47', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4400, '待办任务', 'undo_task', 'task', null, 4000, 'icon-renwu', 'views/activiti/task', 4, '0', '0', '2018-09-27 09:52:31', '2021-02-06 18:47:49', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4401, '流程管理', 'act_task_manage', null, null, 4400, '1', null, 0, '0', '1', '2018-05-15 21:35:18', '2018-09-28 09:12:07', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4500, '订单管理', 'order_manage', '/patent-data/order-info', null, -1, 'icon-denglvlingpai', '/patent-data/index', 11, '0', '1', '2019-06-03 09:58:41', '2021-02-07 17:14:22', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4501, '订单添加', 'order_info_add', '/patent-data/user-info/order-info', 'post', 4500, 'icon-denglvlingpai', '/patent-data/user-info/order-info', 11, '0', '0', '2019-06-03 09:58:41', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4502, '订单删除', 'order_info_delete', '/patent-data/user-info/order-info/{id}', 'delete', 4500, 'icon-denglvlingpai', '/patent-data/user-info/order-info', 11, '0', '0', '2019-06-03 09:58:41', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4503, '订单查询', 'order_info_query', '/patent-data/user-info/order-info/{id}', 'get', 4500, 'icon-denglvlingpai', '/patent-data/user-info/order-info', 11, '0', '0', '2019-06-03 09:58:41', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4504, '订单修改', 'order_info_edit', '/patent-data/user-info/order-info', 'put', 4500, 'icon-denglvlingpai', '/patent-data/user-info/order-info', 11, '0', '0', '2019-06-03 09:58:41', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4505, '添加订单附件', 'add_order_attachment', '/patent-data/user-info/order-info/{id}/attachment', 'post', 4500, 'icon-denglvlingpai', '/patent-data/user-info/order-info', 11, '0', '1', '2019-06-03 09:58:41', '2021-02-07 16:52:10', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4600, '估值管理', 'valuate_mgmt', '/api/v1/valuate', null, -1, 'icon-denglvlingpai', null, 11, '0', '1', '2021-02-06 09:58:41', '2021-02-07 00:55:55', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4601, '估值', 'valuate', '/api/v1/valuate', 'post', 4600, 'icon-denglvlingpai', null, 11, '0', '1', '2021-02-06 09:58:41', '2021-02-07 09:28:17', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4602, '预测专业版', 'forecast_pro', '/api/v1/forecast/pro', 'post', 4600, 'icon-denglvlingpai', null, 11, '0', '1', '2021-02-06 09:58:41', '2021-02-07 09:28:07', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4603, '定制估值预测', 'custom_valuate_forecast', '/api/v1/valuate/forecast/custom', 'post', 4600, 'icon-denglvlingpai', null, 11, '0', '1', '2021-02-06 09:58:41', '2021-02-07 09:28:09', '0', 1);
INSERT INTO sys_menu (menu_id, name, permission, path, http_method, parent_id, icon, component, sort, keep_alive, type, create_time, update_time, del_flag, `show`) VALUES (4604, '估值预测', 'valuate_forecast', '/api/v1/valuate/forecast', 'post', 4600, 'icon-denglvlingpai', null, 11, '0', '1', '2021-02-06 09:58:41', '2021-02-07 09:28:13', '0', 1);
COMMIT;

DROP TABLE IF EXISTS sys_oauth_client_details;
create table sys_oauth_client_details
(
    client_id               varchar(32)                                   not null comment 'OAuth2客户端id'
        primary key,
    resource_ids            varchar(256) default 'oauth2-resource'        not null comment 'OAuth2客户端密码',
    client_secret           varchar(256)                                  not null,
    scope                   varchar(256)                                  not null,
    authorized_grant_types  varchar(256) default 'password,refresh_token' not null,
    web_server_redirect_uri varchar(256)                                  null,
    authorities             varchar(256)                                  null,
    access_token_validity   int          default 3600                     not null,
    refresh_token_validity  int          default 3600                     not null,
    additional_information  varchar(4096)                                 null,
    autoapprove             varchar(256) default '0'                      not null,
    tenant_id               int          default 0                        not null comment '所属租户'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='终端信息表';

BEGIN;
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_auto_dev', 'oauth2-resource', 'auto.dev.pi.s#t!on*#cl@oud!@#2021.v5', 'read_write', 'password,refresh_token, authorization_code', null, null, 3600, 3600, null, 'false', 1);
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_car_data', 'oauth2-resource', 'da.data#t!on*#cl@oud!@#2021.v5', 'read_write', 'password,refresh_token,authorization_code', null, null, 3600, 3600, null, 'false', 1);
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_cloud', 'pistonint_cloud-resource,oauth2-resource', 'pi.s#t!on*#cl@oud!@#2021.v5', 'read_write', 'password,refresh_token,authorization_code,client_credentials', 'http://baidu.com', '', 3600, 3600, '{}', 'false', 1);
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_daemon', 'oauth2-resource', 'da.#t!on*#cl@oud!@#2021.v5', 'read_write', 'password,refresh_token,authorization_code', null, null, 3600, 3600, null, 'false', 1);
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_idata', 'oauth2-resource', 'idata.t!on*#cl@oud!@#2021.v5', 'read_write', 'password,refresh_token,authorization_code', null, null, 3600, 3600, null, 'false', 1);
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_sns', 'oauth2-resource', 'sns.pi.s#t!on*#cl@oud!@#2021.v5', 'read_write', 'password,refresh_token,authorization_code', null, null, 3600, 3600, null, 'false', 1);
INSERT INTO sys_oauth_client_details (client_id, resource_ids, client_secret, scope, authorized_grant_types, web_server_redirect_uri, authorities, access_token_validity, refresh_token_validity, additional_information, autoapprove, tenant_id) VALUES ('pistonint_temparary', 'oauth2-resource', 'kjd#k@s*d.j(k.2021.!m$l%#21', 'read', 'password,refresh_token', null, null, 3600, 3600, null, '0', 1);
COMMIT;

DROP TABLE IF EXISTS sys_public_param;
create table sys_public_param
(
    public_id     bigint auto_increment comment '编号'
        primary key,
    public_name   varchar(128)                         not null comment '公共参数名称',
    public_key    varchar(128)                         not null comment '键,英文大写+下划线',
    public_value  text                                 null comment '值',
    status        char       default '1'               null comment '状态：1有效；2无效；',
    validate_code varchar(64)                          null comment '公共参数编码',
    create_time   timestamp  default CURRENT_TIMESTAMP not null comment '创建时间',
    update_time   timestamp                            null on update CURRENT_TIMESTAMP comment '修改时间',
    public_type   char       default '0'               null comment '配置类型：0-默认；1-检索；2-原文；3-报表；4-安全；5-文档；6-消息；9-其他',
    del_flag      char       default '0'               null comment '删除状态：0-正常；1-已删除',
    tenant_id     int                                  null comment '租户ID',
    `system`      tinyint(1) default 1                 null comment '是否是系统内置'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT COMMENT='公共参数配置表';

BEGIN;
INSERT INTO sys_public_param (public_id, public_name, public_key, public_value, status, validate_code, create_time, update_time, public_type, del_flag, tenant_id, `system`) VALUES (1, '系统首页参数配置', 'INDEX_MSG_CONFIG', '运维电话： 18888888888', '0', null, '2019-04-28 18:24:38', '2019-04-28 18:31:10', '9', '0', 1, 1);
INSERT INTO sys_public_param (public_id, public_name, public_key, public_value, status, validate_code, create_time, update_time, public_type, del_flag, tenant_id, `system`) VALUES (2, '版本信息说明', 'VERSION_INSTRUCTIONS', 'Piston 平台3.1版本', '0', null, '2019-04-28 18:24:38', '2021-02-07 20:50:54', '9', '0', 1, 1);
INSERT INTO sys_public_param (public_id, public_name, public_key, public_value, status, validate_code, create_time, update_time, public_type, del_flag, tenant_id, `system`) VALUES (3, '办公安全支持文件类型', 'OFFICE_SAFETY_FILETYPE', 'PDF,CEB,CEBX,DOC,DOCX,XLS,XLSX,PPT,PPTX,WPS', '0', null, '2019-04-28 18:24:38', '2019-04-28 18:31:10', '4', '0', 1, 1);
COMMIT;

DROP TABLE IF EXISTS sys_role;
create table sys_role
(
    role_id     int auto_increment
        primary key,
    role_name   varchar(64)                         not null,
    role_code   varchar(64)                         not null,
    role_desc   varchar(255)                        null,
    ds_type     char      default '2'               not null comment '数据权限类型',
    ds_scope    varchar(255)                        null comment '数据权限范围',
    create_time timestamp default CURRENT_TIMESTAMP not null,
    update_time timestamp                           null on update CURRENT_TIMESTAMP,
    del_flag    char      default '0'               null comment '删除标识（0-正常,1-删除）',
    tenant_id   int                                 null,
    constraint role_idx1_role_code
        unique (role_code)
)ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='系统角色表';

BEGIN;
INSERT INTO sys_role (role_id, role_name, role_code, role_desc, ds_type, ds_scope, create_time, update_time, del_flag, tenant_id) VALUES (1, '管理员', 'ROLE_ADMIN', '管理员', '0', '2', '2017-10-29 15:45:51', '2018-12-26 14:09:11', '0', 1);
INSERT INTO sys_role (role_id, role_name, role_code, role_desc, ds_type, ds_scope, create_time, update_time, del_flag, tenant_id) VALUES (2, '添加租户初始化角色', 'ROLE_TENANT_INIT', '添加租户初始化角色', '2', null, '2018-11-11 19:42:26', '2021-02-07 21:50:34', '0', 1);
INSERT INTO sys_role (role_id, role_name, role_code, role_desc, ds_type, ds_scope, create_time, update_time, del_flag, tenant_id) VALUES (3, '优车库', 'youcheku', '优车库角色', '2', null, '2021-02-23 23:51:11', '2021-02-23 23:59:21', '0', 2);
INSERT INTO sys_role (role_id, role_name, role_code, role_desc, ds_type, ds_scope, create_time, update_time, del_flag, tenant_id) VALUES (6, 'test', 'test', '测试', '3', '', '2021-02-24 16:07:39', null, '0', 1);
COMMIT;


DROP TABLE IF EXISTS sys_role_menu;
create table sys_role_menu
(
    role_id int not null comment '角色ID',
    menu_id int not null comment '菜单ID',
    primary key (role_id, menu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色菜单表';

BEGIN;
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1101);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1102);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1103);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1104);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1105);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1106);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1107);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1108);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1109);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1110);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1111);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1112);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1113);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1114);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1200);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1201);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1202);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1203);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1204);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1205);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1206);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1207);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1300);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1301);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1302);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1303);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1304);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1305);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1306);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1307);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1308);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1400);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1401);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1402);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1403);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1404);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1405);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1406);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1407);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1408);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1500);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1501);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1502);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1503);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1504);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1505);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1506);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 1507);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2101);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2102);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2103);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2104);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2105);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2106);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2107);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2108);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2109);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2110);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2200);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2201);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2202);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2203);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2210);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2211);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2212);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2213);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2214);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2215);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2216);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2300);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2400);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2401);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2402);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2403);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2404);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2405);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2500);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2501);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2502);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2503);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2504);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2505);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2506);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2507);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2600);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2601);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2700);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2800);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2810);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2820);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2830);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2840);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2850);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 2860);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 3000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 3100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 3200);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 3300);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 3400);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 3800);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4101);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4200);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4201);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4300);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4301);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4302);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4303);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4400);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4401);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4600);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4601);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4602);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4603);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (1, 4604);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1101);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1102);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1104);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1105);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1106);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1107);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1109);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1110);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1111);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1200);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1201);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1202);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1400);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1401);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (2, 1402);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1000);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1100);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1101);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1102);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1103);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1104);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1105);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1106);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1107);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1108);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1109);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1110);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1111);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1112);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1113);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1114);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1200);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1201);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1202);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1203);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1204);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1205);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1207);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1300);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1301);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1302);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1303);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1304);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1305);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1306);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1307);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1308);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1400);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1401);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1402);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1403);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1404);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1405);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1406);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1407);
INSERT INTO sys_role_menu (role_id, menu_id) VALUES (3, 1408);
COMMIT;

DROP TABLE IF EXISTS sys_route_conf;
create table sys_route_conf
(
    id          int auto_increment comment '主键'
        primary key,
    route_name  varchar(30)                            null comment '路由名称',
    route_id    varchar(100) default ''                not null comment '路由ID',
    predicates  json                                   null comment '断言',
    filters     json                                   null comment '过滤器',
    uri         varchar(50)                            null,
    `order`     int(2)       default 0                 null comment '排序',
    create_time datetime     default CURRENT_TIMESTAMP null comment '创建时间',
    update_time datetime                               null on update CURRENT_TIMESTAMP comment '修改时间',
    del_flag    char         default '0'               null comment '删除标记'
)ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='路由配置表';

BEGIN;
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (1, '工作流管理模块', 'pistonint-activiti', '[{"args": {"_genkey_0": "/act/**"}, "name": "Path"}]', '[]', 'http://pistonint-activiti', 0, '2019-03-26 22:46:09', '2021-03-02 19:03:21', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (2, '认证中心', 'pistonint-auth', '[{"args": {"_genkey_0": "/auth/**"}, "name": "Path"}]', '[{"args": {}, "name": "ValidateCodeGatewayFilter"}, {"args": {}, "name": "PasswordDecoderFilter"}]', 'http://pistonint-auth:3000', 0, '2019-03-26 22:46:09', '2021-03-02 22:01:05', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (3, '代码生成模块', 'pistonint-automation-development', '[{"args": {"_genkey_0": "/gen/**"}, "name": "Path"}]', '[]', 'http://pistonint-auto-dev:18080', 0, '2019-03-26 22:46:09', '2021-03-02 19:10:50', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (4, 'elastic-job定时任务模块', 'pistonint-daemon-elastic-job', '[{"args": {"_genkey_0": "/daemon/**"}, "name": "Path"}]', '[]', 'http://pistonint-daemon-elastic-job', 0, '2019-03-26 22:46:09', '2021-03-02 19:03:30', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (5, 'quartz定时任务模块', 'pistonint-daemon-quartz', '[{"args": {"_genkey_0": "/job/**"}, "name": "Path"}]', '[]', 'http://pistonint-daemon-quartz', 0, '2019-03-26 22:46:09', '2021-03-02 19:03:34', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (6, '分布式事务模块', 'pistonint-tx-manager', '[{"args": {"_genkey_0": "/tx/**"}, "name": "Path"}]', '[]', 'http://pistonint-tx-manager', 0, '2019-03-26 22:46:09', '2021-03-02 19:03:36', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (7, '通用权限模块', 'pistonint-upms', '[{"args": {"_genkey_0": "/admin/**"}, "name": "Path"}]', '[{"args": {"key-resolver": "#{@remoteAddrKeyResolver}", "redis-rate-limiter.burstCapacity": "20", "redis-rate-limiter.replenishRate": "10"}, "name": "RequestRateLimiter"}]', 'http://pistonint-upms:4000', 0, '2019-03-26 22:46:09', '2021-03-02 19:10:41', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (8, '工作流长链接支持1', 'pistonint-activiti-ws-1', '[{"args": {"_genkey_0": "/act/ws/info/**"}, "name": "Path"}]', '[]', 'http://pistonint-activiti', 0, '2019-03-26 22:46:09', '2021-03-02 19:03:40', '0');
INSERT INTO sys_route_conf (id, route_name, route_id, predicates, filters, uri, `order`, create_time, update_time, del_flag) VALUES (9, '工作流长链接支持2', 'pistonint-activiti-ws-2', '[{"args": {"_genkey_0": "/act/ws/**"}, "name": "Path"}]', '[]', 'lb:ws://pistonint-activiti', 100, '2019-03-26 22:46:09', '2021-03-02 19:03:43', '0');
COMMIT;

DROP TABLE IF EXISTS sys_social_details;
create table sys_social_details
(
    id           int auto_increment comment '主鍵'
        primary key,
    type         varchar(16)                        not null comment '类型',
    remark       varchar(64)                        null comment '描述',
    app_id       varchar(64)                        not null comment 'appid',
    app_secret   varchar(64)                        not null comment 'app_secret',
    redirect_url varchar(128)                       null comment '回调地址',
    create_time  datetime default CURRENT_TIMESTAMP null comment '创建时间',
    update_time  datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '更新时间',
    del_flag     char     default '0'               not null comment '删除标记',
    tenant_id    int      default 0                 not null comment '所属租户'
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='系统社交登录账号表';

BEGIN;
INSERT INTO sys_social_details (id, type, remark, app_id, app_secret, redirect_url, create_time, update_time, del_flag, tenant_id) VALUES (1, 'WX', '微信互联参数', 'wxd1678d3f83b1d83a', '6ddb043f94da5d2172926abe8533504f', 'daoweicloud.com', '2018-08-16 14:24:25', '2019-03-02 09:43:13', '0', 1);
COMMIT;

DROP TABLE IF EXISTS sys_user;
create table sys_user
(
    user_id         int auto_increment comment '主键ID'
        primary key,
    uuid            varchar(32)                          null,
    username        varchar(64)                          not null comment '用户名',
    password        varchar(255)                         not null,
    salt            varchar(255)                         null comment '随机盐',
    phone           varchar(20)                          null comment '手机号码',
    avatar          varchar(255)                         null comment '头像',
    dept_id         int                                  null comment '部门ID',
    create_time     timestamp  default CURRENT_TIMESTAMP null comment '创建时间',
    update_time     timestamp                            null on update CURRENT_TIMESTAMP comment '修改时间',
    lock_flag       char       default '0'               null comment '0-正常，9-锁定',
    del_flag        char       default '0'               null comment '0-正常，1-删除',
    wx_openid       varchar(32)                          null comment '微信openid',
    qq_openid       varchar(32)                          null comment 'QQ openid',
    tenant_id       int        default 0                 not null comment '所属租户',
    email           varchar(100)                         null comment '邮箱',
    effective_date  timestamp                            null comment '有效时间开始时间',
    expiration_date timestamp                            null comment '有效时间结束时间',
    sex             char                                 null comment '1-男，2-女',
    strict_per      tinyint(1) default 0                 null comment '严格权限检查',
    constraint user_idx1_username
        unique (username),
    constraint user_tenant_uaername_uq
        unique (username, tenant_id)
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';

create index user_qq_openid
    on sys_user (qq_openid);

create index user_wx_openid
    on sys_user (wx_openid);

BEGIN;
INSERT INTO sys_user (user_id, uuid, username, password, salt, phone, avatar, dept_id, create_time, update_time, lock_flag, del_flag, wx_openid, qq_openid, tenant_id, email, effective_date, expiration_date, sex, strict_per) VALUES (1, null, 'admin', '$2a$10$5EXn4lQBd7nBT/bRccAMIurGyW1m9P9CXMHNKGhRp.kJ1ZJh.ZC.i', '', '17665107466', '1.jpeg', 1, '2018-04-20 07:15:18', '2021-02-07 10:39:56', '0', '0', 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', null, 1, 'cxlu@pistonint_cloud.biz', null, null, null, 0);
INSERT INTO sys_user (user_id, uuid, username, password, salt, phone, avatar, dept_id, create_time, update_time, lock_flag, del_flag, wx_openid, qq_openid, tenant_id, email, effective_date, expiration_date, sex, strict_per) VALUES (2, null, 'pistonint.cloud', '$2a$10$Xn1gPWxvQaarKGawXEutduafxvlJfCe0U7f.Lep6anHhQE1VBHc5y', '', '17034642889', '1.jpeg', 1, '2018-04-20 07:15:18', '2021-02-07 10:39:58', '0', '0', 'o_0FT0uyg_H1vVy2H0JpSwlVGhWQ', null, 1, null, null, null, null, 0);
INSERT INTO sys_user (user_id, uuid, username, password, salt, phone, avatar, dept_id, create_time, update_time, lock_flag, del_flag, wx_openid, qq_openid, tenant_id, email, effective_date, expiration_date, sex, strict_per) VALUES (586, 'e5e96db0fa1c4e6abbe3be8630ee4f0c', 'dev', '$2a$10$QTyP/rzgYFgVjr8bPanTz.Se89/qXwEwL1qtN7Y76aVHCm5Ff1Xji', null, '18888888888', null, 2, '2021-02-23 22:41:12', '2021-02-23 22:48:50', '0', '0', null, null, 2, null, null, null, null, 0);
COMMIT;

DROP TABLE IF EXISTS sys_tenant;
create table sys_tenant
(
    id          int auto_increment comment '租户id'
        primary key,
    name        varchar(400)                        not null comment '租户名称',
    en_name     varchar(255)                        null comment '英文名称',
    type        varchar(255)                        null,
    code        varchar(64)                         null comment '租户编号',
    start_time  timestamp                           null comment '开始时间',
    end_time    timestamp                           null comment '结束时间',
    status      char      default '0'               not null comment '0正常 9-冻结',
    del_flag    char      default '0'               null comment '删除标记',
    create_time timestamp default CURRENT_TIMESTAMP not null comment '创建',
    update_time timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    email       varchar(255)                        null comment '邮箱',
    phone       varchar(20)                         null comment '联系电话'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='租户表';

BEGIN;
INSERT INTO sys_tenant (id, name, en_name, type, code, start_time, end_time, status, del_flag, create_time, update_time, email, phone) VALUES (1, '广东数鼎科技有限公司', 'pistonint', '1', 'pistonint', null, null, '0', '0', '2021-02-15 09:50:16', '2021-02-15 09:54:06', null, '020-85588156');
INSERT INTO sys_tenant (id, name, en_name, type, code, start_time, end_time, status, del_flag, create_time, update_time, email, phone) VALUES (2, '优车库网络科技发展（深圳）有限公司', 'YouCKU', '2', 'YouCKU', null, null, '0', '0', '2021-02-23 23:50:00', '2021-02-23 23:50:00', null, null);
COMMIT;

DROP TABLE IF EXISTS sys_user_dept;
create table sys_user_dept
(
    dept_id int(20) auto_increment
        primary key,
    user_id int null comment '排序'
)
    comment '部门管理' charset = utf8;

BEGIN;
INSERT INTO sys_user_dept (dept_id, user_id) VALUES (10, 586);
COMMIT;

DROP TABLE IF EXISTS sys_user_role;
create table sys_user_role
(
    user_id int not null comment '用户ID',
    role_id int not null comment '角色ID',
    primary key (user_id, role_id)
)
    comment '用户角色表' charset = utf8;

BEGIN;
INSERT INTO sys_user_role (user_id, role_id) VALUES (1, 1);
INSERT INTO sys_user_role (user_id, role_id) VALUES (2, 1);
INSERT INTO sys_user_role (user_id, role_id) VALUES (586, 3);
COMMIT;

DROP TABLE IF EXISTS undo_log;
create table undo_log
(
    id            bigint auto_increment
        primary key,
    branch_id     bigint       not null,
    xid           varchar(100) not null,
    context       varchar(128) not null,
    rollback_info longblob     not null,
    log_status    int          not null,
    log_created   datetime     not null,
    log_modified  datetime     not null,
    ext           varchar(100) null,
    constraint ux_undo_log
        unique (xid, branch_id)
)
    charset = utf8;

DROP TABLE IF EXISTS sys_rsa_key;
create table sys_rsa_key
(
    id          int auto_increment comment '主键'
        primary key,
    name        varchar(400)  not null comment '名称',
    private_key blob          not null,
    public_key  blob          not null,
    tenant_id   int default 1 not null,
    constraint name_uq_index
        unique (name)
);

BEGIN;
INSERT INTO sys_rsa_key (id, name, private_key, public_key, tenant_id) VALUES (1, 'auto_dev', 0x308204BD020100300D06092A864886F70D0101010500048204A7308204A30201000282010100AA8FA984AF8D0AA675BA00B6EE6F4056ED53041E64641F67D9BB011D4D86C9C33D06F28FD8BE2A756FDC734FD279E7B3066BD65F08307BCF1DBDDCA011D3338874C4FA74940CCD0616CF545E6E3B065DC31764DC7EDD850D848F10029129387FE5D81E58D8B330A5227CF5DD9E107411A5D9D60943F12A37F2C87B998B6D32E4CFE16F59C8BE94EA658BEC37B2FD0FD4C1FA07C63C7EB5E369AA601013BA7CA689C627FA8F32F7646B71C110F3408657C6E9D0D83A6168D877E7BD85D448F7E9C7DFD860D5D7AB2622A8DA49A8C7C140813B08ED487A61FAA44EEEC90D9D9AD78AF559F3E46D4698B9318FAE3560025D720C25481922F44CB583E598EF5DCA8B0203010001028201001FB0313E859F1EAB6E93F02E0C7E7EE5A79214E1D0A50970B1F31C71E5457596E06FBA011FB3B50FBC88A8A3DBE6EA3548AC2057E79D9A63109385B9F795D5AD3484A443A47DFC5975436FD95B817BDD4FB1B8FB7E5689B1C93F0B2A6EEDC9A179827DA0E421E697C7A08FCD6CE081B005B04323D58BA8DC5C2F0347B3AFC6148E7FC55DB70307F8509F4B02B9ACC725EFCF05451F32E992DF360DA4BA646B436DE1BDD18CC8A80D02B3BC2ABC227A2352120486783AA1D4D27F4E0802F509EF99439EE9141F29164B5C948DAD700984ABF7C4D97AAC35951A1C9287C0314C7760057F8B1EA4C256D80DA5906E036412BED568171CE58CC86F3EE28651CB728102818100EDBF8E36354051649E70842259869E6B6EFFC68E371A83725EF10336C175C8B8001D68CD3D583B39B0BC818A584B819204D3E7B815457CFD844FF147E0D8B45C4B3C152DE6CED5E3925122BD60A9BD09BF70320DDDD2FE8C7803A4BBF280F07449B4EEA54E02D6BEBAE80A2ACF228AB3FB83AC8998B3DDF39F88996D897B9B7D02818100B7A7AF679AE0D9A792CE20634BAE449CFBBEF11193DB191709DD165093004B7BA21B8CA5DD3EE1635AD1878C2648FC93B6DF467757359CD0188297F23D82288B1096789671B87E0492A3127F1EC9C5354BCA7C5AE2A0FDCF661E9E65858F72B30E2F459E0415A4C23A1266F0FD8A1F6572FF6957CB856C2C17827E2F01EF8CA70281805CEA895CDC30F7DE78218732998488337A9D11EF90CF96E1C303347B58DE7C8494DEE98F94D2FFCA8B2D10FF8D846CEE315ED3E7D8C06099FFF4F25A6220AF5486BEC3943DE946247B91A41F19411D354B11412EB42BFAF9D109B37F14C699B308FF62694E74C392A51F7CA1C074427B16E81E2D64759F5FD050A58DEEB6554D02818057A46B1D6B18C065AAB63958896639921CC52B2FB33A8C87A50A5FBAC5DC0F2989DBD1CBD9804778ED7F2E4B607DD622FBD323429258A063E23E781A7EE5DD4937FA46C3ACB35957FF4E58E6571FFCBF8952B0F3825147AE30D28DCE6EE55CDC3BF9AD245258ADCE8E7DF7A82BA63D836154A7C5E0F6E3FF4A9CD870C060BBE302818100A1A71A78334593558A86435A3CA5E0703ECF6FB7C442E8142D883CD6FB933228FCA205E87F1B3AE24CA63E6F0CEA5C72D50BB594397D249B7F5E08232BD4A91CC60DF7FF69EF3F8E130C8E646459B4CE303E3F6419DF1E88AD06482BDFDF0B92687BF0F870CC01237D8C98A895E1D4A21FD216D0FD750CCBC09243F1B19D65F3, 0x30820122300D06092A864886F70D01010105000382010F003082010A0282010100AA8FA984AF8D0AA675BA00B6EE6F4056ED53041E64641F67D9BB011D4D86C9C33D06F28FD8BE2A756FDC734FD279E7B3066BD65F08307BCF1DBDDCA011D3338874C4FA74940CCD0616CF545E6E3B065DC31764DC7EDD850D848F10029129387FE5D81E58D8B330A5227CF5DD9E107411A5D9D60943F12A37F2C87B998B6D32E4CFE16F59C8BE94EA658BEC37B2FD0FD4C1FA07C63C7EB5E369AA601013BA7CA689C627FA8F32F7646B71C110F3408657C6E9D0D83A6168D877E7BD85D448F7E9C7DFD860D5D7AB2622A8DA49A8C7C140813B08ED487A61FAA44EEEC90D9D9AD78AF559F3E46D4698B9318FAE3560025D720C25481922F44CB583E598EF5DCA8B0203010001, 1);
INSERT INTO sys_rsa_key (id, name, private_key, public_key, tenant_id) VALUES (2, 'auth', 0x308204BE020100300D06092A864886F70D0101010500048204A8308204A4020100028201010087574C021A39C86D6882061AF77BB1BEA983898E7E74C415CB4A57F2CC5D4AA2492543951701A7B42AD7210B214A41F92B4369105E50860F0C2A19690CC2D16097F95A82565BB41055D358A036760B64C3F7A156A3E7D38D50552D0897F599AC58D54FF0E5D8B34C30814CB4B0352A62A89137D5A02ED83735E714F539F6AD32A93B155EC162C6B2EEFFC175736B39E7B6890A6175A07A2A522220DFF7A9BDD36F5DE2398CC7CB96A5FEB3AEE00C9A55B6F3421E84946094E51C9F7A168BCB629A74F8B376895BCEE0E00585AB5920FB8262C10D06AA53B06A29BAF7AE6341B62D8A4791D56DDB1C9994735ADA984E3010012CCF695C0804FBA6F0E1420C820502030100010282010054B897F304F9C0F6842248B21ED406AB44AFFBAF008815AB52EBC1EC5273DFE1810A5BA8FB92E4A94ADC0A6A4E378EDEEC6F3158B6C18F79E1F2849F9706694D1F354FAC21651C6DD15C10B192060911D5FEB0B76CB9155BF3BAAE0B201CF54AC6FD1922C2AF09661B430582627F957DD6E9B8DAF87FFA876D2DAF97E6E5FCFABC0E24375A7209D4E6FFB21A865B3CAD125350460E88AAA3BDB618352315AB6F8E1156D7829A1172EF1F29B980D012E846A11D79FFA5034DCB2E50FEF0824803B01BAA3596DED37A66E807F0C2B27B974123FE2DFEAADCA2DA78580F083E6B6BBCDA253602E946945339FD30B81356668E9537D628D8DABD4E3E61557052BD8102818100D0ED8E43CFCE0E2101380F30D9E7C37B3CCE48D80CF7BFBD2D06F5EB833819B225741361F9472A32B7144E4DFC22F7114BA2DF22CEDFF0BA7F017D0EE25AEF07BEDAE5828BB5E67B43F20E8EF3CCBBC07151E910037A2D90631D84D7BD728D24DB6741F75BC3B08A1EDEE05FD2AB0BF73071E77376E8C833B02699CB6B31302502818100A5D56DDC6853DA7AA5E8BCAE6A96E8129CA25C16D450A2BC844CC223774732F08352A797C31DF6317A7FEF46344B4274CA014AF217D15C2F7F8F04A87C167FD3B250AEE60DE9571456054756660EB63A94E47E4B121F1C8F91906C5E1A6723640C17AA1DCA85A89E4FD019236580C0BDA4D9151A25B002FE8C5819B5768EF46102818100AC324F2206E0FEF626EA0C6328060430CB71FDC9CC0E5A02D25CBD4D69EE50076B251B6091B31CCD85E57F9078F25C8DEDB8048ECCD0F7B8CE3AECD6DAAB35FD3D496F06449E1CA395E1A82C1C36AEBC32E9DEDC6AF145228EFE6261E9EBC2F710BA2F3D6F6D7F50A796EC792DC9FA67B68EFAC348CB1D4EB4AD6BEEA39F7BDD0281805882A0BF6A038F71B4C992A3390AD054D6BB25919DC268095C47A7BACC37F92D3BBA4AEF0A5A1C83EE1108819CF9AA3FB16D9D35B796ABB04251F03788FB6D406D44F9049ADA36FB08AA8A97C7A3048A21DC0EB83CB4D446A077C80F35E264964A89FAE729A7CB06AC2CB2AE1CC7EA978DBBBBB297F8E8B039F1EFCED5B7992102818100CC273C8D140428D7E9E8E3BD12BE535E9ACB9E732115A652437EF98B406E1A09F9B51B8203C52EDC2B81C46A3E91E186C392ECE15DA289D88D94A3667A816047989664BB5A45E61A6E395D5918F90EAA82CEA288956231745657D9BCAC830473D4B95ADF94305BAACF76AA9C1143736D8D5A8BB9D018483F5B05CC0F993C1CE0, 0x30820122300D06092A864886F70D01010105000382010F003082010A028201010087574C021A39C86D6882061AF77BB1BEA983898E7E74C415CB4A57F2CC5D4AA2492543951701A7B42AD7210B214A41F92B4369105E50860F0C2A19690CC2D16097F95A82565BB41055D358A036760B64C3F7A156A3E7D38D50552D0897F599AC58D54FF0E5D8B34C30814CB4B0352A62A89137D5A02ED83735E714F539F6AD32A93B155EC162C6B2EEFFC175736B39E7B6890A6175A07A2A522220DFF7A9BDD36F5DE2398CC7CB96A5FEB3AEE00C9A55B6F3421E84946094E51C9F7A168BCB629A74F8B376895BCEE0E00585AB5920FB8262C10D06AA53B06A29BAF7AE6341B62D8A4791D56DDB1C9994735ADA984E3010012CCF695C0804FBA6F0E1420C82050203010001, 1);
INSERT INTO sys_rsa_key (id, name, private_key, public_key, tenant_id) VALUES (4, 'login', 0x30820278020100300D06092A864886F70D0101010500048202623082025E020100028181009A5FFA2848091724DB0D66A1CF3924912A809E583DC2262A73DC30612C21C051862FC076740261164ABCE109EE15E72FF8B332A29B073786DABD0B2092DAC7C983D42FD03192EA79722B39CD44504C7669A5BBBE5095ED0085AE558F0E09CF11599813F3921350B2F9235B9861E9A0B8D4E98117D2C6A4D72FFCED0B624D8B5702030100010281801D58654B46F6436A0421F602884BCA81B5DCA13D10F05924F4C5448514488E30711B9EB065B9160F90C17ADDD25E638620F69F877D84CFAF58E15ABE246C6651C1D71727D8F0640F5B8A459388F4D09927D7B6A6C5D991477F0D90DBEAC4AF0E2CAAA81A8C74711B745361A4D00488CABBD361EC824145700D619DED18FEE3E1024100E5D636210CB7FE4C2BA63D694B609AEB113150C820586F2AD719FE36E97AF544B8EE315BAF24A5FD6153B2F1FABA0F0D91AE0F871DD8F9ECAD8BE423ADF8B3E9024100ABF2B1A939512EADC19DA9B483830A11F94B795604D568711BAC4D9D5C11B5F1B42B0A64809AF5828F930A2BFA93B55B6FFC5274CC27409BF44A409E926CFD3F024100C6CBE7F9E2346B629B06A96B9FE5295A557EA06ED97B647C5B9D82032124576D5FBFB735A46240A8CF3C44358536D5BA58DD8354CD7E557E6005F608DE7B95B1024100A41A6CEA77947E3B40A4CB3947A6416F24009F1DB461445B66B0CC26599F6188FB8D744EB4DAAF635AC95794DF82273CCC2501410D328D1C0A4AEF5F279A331B024100BB8E297D004EF239B9EC4BCFDFB12872C0AFE445A2CD695F21B2815D53A3D277CD60577DDC6116279F6E8BD9DDE46F8E25CC402D0B0622EC81399A85D20CE0F3, 0x30819F300D06092A864886F70D010101050003818D00308189028181009A5FFA2848091724DB0D66A1CF3924912A809E583DC2262A73DC30612C21C051862FC076740261164ABCE109EE15E72FF8B332A29B073786DABD0B2092DAC7C983D42FD03192EA79722B39CD44504C7669A5BBBE5095ED0085AE558F0E09CF11599813F3921350B2F9235B9861E9A0B8D4E98117D2C6A4D72FFCED0B624D8B570203010001, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
