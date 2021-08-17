USE pistonint_cloud_job;

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `job_execution_log`;
create table job_execution_log
(
    id               varchar(40)   not null
        primary key,
    job_name         varchar(100)  not null,
    task_id          varchar(255)  not null,
    hostname         varchar(255)  not null,
    ip               varchar(50)   not null,
    sharding_item    int           not null,
    execution_source varchar(20)   not null,
    failure_cause    varchar(4000) null,
    is_success       int           not null,
    start_time       timestamp     null,
    complete_time    timestamp     null
)
    comment '任务日志表';

DROP TABLE IF EXISTS `job_status_trace_log`;
create table job_status_trace_log
(
    id               varchar(40)   not null
        primary key,
    job_name         varchar(100)  not null,
    original_task_id varchar(255)  not null,
    task_id          varchar(255)  not null,
    slave_id         varchar(50)   not null,
    source           varchar(50)   not null,
    execution_type   varchar(20)   not null,
    sharding_item    varchar(100)  not null,
    state            varchar(20)   not null,
    message          varchar(4000) null,
    creation_time    timestamp     null
)
    comment '任务轨迹表';

create index TASK_ID_STATE_INDEX
    on job_status_trace_log (task_id, state);

DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
create table QRTZ_BLOB_TRIGGERS
(
    sched_name    varchar(120) not null,
    trigger_name  varchar(200) not null,
    trigger_group varchar(200) not null,
    blob_data     blob         null,
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_blob_triggers_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
);

DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
create table QRTZ_CALENDARS
(
    sched_name    varchar(120) not null,
    calendar_name varchar(200) not null,
    calendar      blob         not null,
    primary key (sched_name, calendar_name)
);

DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
create table QRTZ_CRON_TRIGGERS
(
    sched_name      varchar(120) not null,
    trigger_name    varchar(200) not null,
    trigger_group   varchar(200) not null,
    cron_expression varchar(200) not null,
    time_zone_id    varchar(80)  null,
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_cron_triggers_ibfk_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
);

DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
create table QRTZ_FIRED_TRIGGERS
(
    sched_name        varchar(120) not null,
    entry_id          varchar(95)  not null,
    trigger_name      varchar(200) not null,
    trigger_group     varchar(200) not null,
    instance_name     varchar(200) not null,
    fired_time        bigint(13)   not null,
    sched_time        bigint(13)   not null,
    priority          int          not null,
    state             varchar(16)  not null,
    job_name          varchar(200) null,
    job_group         varchar(200) null,
    is_nonconcurrent  varchar(1)   null,
    requests_recovery varchar(1)   null,
    primary key (sched_name, entry_id)
);

DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
create table QRTZ_JOB_DETAILS
(
    sched_name        varchar(120) not null,
    job_name          varchar(200) not null,
    job_group         varchar(200) not null,
    description       varchar(250) null,
    job_class_name    varchar(250) not null,
    is_durable        varchar(1)   not null,
    is_nonconcurrent  varchar(1)   not null,
    is_update_data    varchar(1)   not null,
    requests_recovery varchar(1)   not null,
    job_data          blob         null,
    primary key (sched_name, job_name, job_group)
);

DROP TABLE IF EXISTS `QRTZ_LOCKS`;
create table QRTZ_LOCKS
(
    sched_name varchar(120) not null,
    lock_name  varchar(40)  not null,
    primary key (sched_name, lock_name)
);

BEGIN;
INSERT INTO QRTZ_LOCKS (sched_name, lock_name) VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO QRTZ_LOCKS (sched_name, lock_name) VALUES ('clusteredScheduler', 'TRIGGER_ACCESS');
COMMIT;

DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
create table QRTZ_PAUSED_TRIGGER_GRPS
(
    sched_name    varchar(120) not null,
    trigger_group varchar(200) not null,
    primary key (sched_name, trigger_group)
);

DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
create table QRTZ_SCHEDULER_STATE
(
    sched_name        varchar(120) not null,
    instance_name     varchar(200) not null,
    last_checkin_time bigint(13)   not null,
    checkin_interval  bigint(13)   not null,
    primary key (sched_name, instance_name)
);

BEGIN;
INSERT INTO QRTZ_SCHEDULER_STATE (sched_name, instance_name, last_checkin_time, checkin_interval) VALUES ('clusteredScheduler', '693876e511cb1623230983841', 1623335101267, 10000);
COMMIT;

DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
create table QRTZ_SIMPLE_TRIGGERS
(
    sched_name      varchar(120) not null,
    trigger_name    varchar(200) not null,
    trigger_group   varchar(200) not null,
    repeat_count    bigint(7)    not null,
    repeat_interval bigint(12)   not null,
    times_triggered bigint(10)   not null,
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_SIMPLE_TRIGGERS_IBFK_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
);

DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
create table QRTZ_SIMPROP_TRIGGERS
(
    sched_name    varchar(120)   not null,
    trigger_name  varchar(200)   not null,
    trigger_group varchar(200)   not null,
    str_prop_1    varchar(512)   null,
    str_prop_2    varchar(512)   null,
    str_prop_3    varchar(512)   null,
    int_prop_1    int            null,
    int_prop_2    int            null,
    long_prop_1   bigint         null,
    long_prop_2   bigint         null,
    dec_prop_1    decimal(13, 4) null,
    dec_prop_2    decimal(13, 4) null,
    bool_prop_1   varchar(1)     null,
    bool_prop_2   varchar(1)     null,
    primary key (sched_name, trigger_name, trigger_group),
    constraint QRTZ_SIMPROP_TRIGGERS_IBFK_1
        foreign key (sched_name, trigger_name, trigger_group) references QRTZ_TRIGGERS (sched_name, trigger_name, trigger_group)
);

DROP TABLE IF EXISTS QRTZ_TRIGGERS;
create table QRTZ_TRIGGERS
(
    sched_name     varchar(120) not null,
    trigger_name   varchar(200) not null,
    trigger_group  varchar(200) not null,
    job_name       varchar(200) not null,
    job_group      varchar(200) not null,
    description    varchar(250) null,
    next_fire_time bigint(13)   null,
    prev_fire_time bigint(13)   null,
    priority       int          null,
    trigger_state  varchar(16)  not null,
    trigger_type   varchar(8)   not null,
    start_time     bigint(13)   not null,
    end_time       bigint(13)   null,
    calendar_name  varchar(200) null,
    misfire_instr  smallint(2)  null,
    job_data       blob         null,
    primary key (sched_name, trigger_name, trigger_group),
    constraint qrtz_triggers_ibfk_1
        foreign key (sched_name, job_name, job_group) references QRTZ_JOB_DETAILS (sched_name, job_name, job_group)
);

create index sched_name
    on QRTZ_TRIGGERS (sched_name, job_name, job_group);

DROP TABLE IF EXISTS sys_job;
create table sys_job
(
    job_id              int auto_increment comment '任务id',
    job_name            varchar(64)                            not null comment '任务名称',
    job_group           varchar(64)                            not null comment '任务组名',
    job_order           char                                   null comment '组内执行顺利，值越大执行优先级越高，最大值9，最小值1',
    job_type            char         default '1'               not null comment '1、java类;2、spring bean名称;3、rest调用;4、jar调用;9其他',
    execute_path        varchar(500)                           null comment 'job_type=3时，rest调用地址，仅支持rest get协议,需要增加String返回值，0成功，1失败;job_type=4时，jar路径;其它值为空',
    class_name          varchar(500)                           null comment 'job_type=1时，类完整路径;job_type=2时，spring bean名称;其它值为空',
    method_name         varchar(500)                           null comment '任务方法',
    method_params_value varchar(2000)                          null comment '参数值',
    cron_expression     varchar(255)                           null comment 'cron执行表达式',
    misfire_policy      varchar(20)  default '3'               null comment '错失执行策略（1错失周期立即执行 2错失周期执行一次 3下周期执行）',
    job_tenant_type     char         default '1'               null comment '1、多租户任务;2、非多租户任务',
    job_status          char         default '0'               null comment '状态（1、未发布;2、运行中;3、暂停;4、删除;）',
    job_execute_status  char         default '0'               null comment '状态（0正常 1异常）',
    create_by           varchar(64)                            null comment '创建者',
    create_time         timestamp    default CURRENT_TIMESTAMP not null comment '创建时间',
    update_by           varchar(64)  default ''                null comment '更新者',
    update_time         timestamp    default CURRENT_TIMESTAMP not null comment '更新时间',
    start_time          timestamp                              null comment '初次执行时间',
    previous_time       timestamp                              null comment '上次执行时间',
    next_time           timestamp                              null comment '下次执行时间',
    tenant_id           int          default 1                 null comment '租户',
    remark              varchar(500) default ''                null comment '备注信息',
    primary key (job_id, job_name, job_group)
)
    comment '定时任务调度表';

BEGIN;
INSERT INTO sys_job (job_id, job_name, job_group, job_order, job_type, execute_path, class_name, method_name, method_params_value, cron_expression, misfire_policy, job_tenant_type, job_status, job_execute_status, create_by, create_time, update_by, update_time, start_time, previous_time, next_time, tenant_id, remark) VALUES (1, '测试任务', 'demo', '5', '2', '', 'demo', 'demoMethod', 'pistonint', '0 * * * * ? *', '3', '1', '2', '0', 'admin', '2019-03-25 14:00:14', 'admin', '2019-03-25 14:00:14', '2019-03-26 09:43:18', '2019-03-26 10:55:00', '2019-03-26 10:56:00', 1, '演示Spring Bean的定时任务');
COMMIT;

DROP TABLE IF EXISTS sys_job_log;
create table sys_job_log
(
    job_log_id          int auto_increment comment '任务日志ID'
        primary key,
    job_id              int                                     not null comment '任务id',
    job_name            varchar(64)                             null comment '任务名称',
    job_group           varchar(64)                             null comment '任务组名',
    job_order           char                                    null comment '组内执行顺利，值越大执行优先级越高，最大值9，最小值1',
    job_type            char          default '1'               not null comment '1、java类;2、spring bean名称;3、rest调用;4、jar调用;9其他',
    execute_path        varchar(500)                            null comment 'job_type=3时，rest调用地址，仅支持post协议;job_type=4时，jar路径;其它值为空',
    class_name          varchar(500)                            null comment 'job_type=1时，类完整路径;job_type=2时，spring bean名称;其它值为空',
    method_name         varchar(500)                            null comment '任务方法',
    method_params_value varchar(2000)                           null comment '参数值',
    cron_expression     varchar(255)                            null comment 'cron执行表达式',
    job_message         varchar(500)                            null comment '日志信息',
    job_log_status      char          default '0'               null comment '执行状态（0正常 1失败）',
    execute_time        varchar(30)                             null comment '执行时间',
    exception_info      varchar(2000) default ''                null comment '异常信息',
    create_time         timestamp     default CURRENT_TIMESTAMP not null comment '创建时间',
    tenant_id           int           default 1                 not null comment '租户id'
)
    comment '定时任务执行日志表';

SET FOREIGN_KEY_CHECKS = 1;
