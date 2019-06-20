export const tableOption = {
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  menuWidth: 150,
  menuBtn: true,
  align: 'center',
  addBtn: true,
  editBtn: false,
  delBtn: false,
  menuType: 'menu',
  searchShow: false,
  column: [{
    fixed: true,
    label: '转换id',
    prop: 'transformId',
    rules: [{
      required: true,
      message: '请输入转换id',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '源节点组id',
    prop: 'sourceNodeGroupId',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入源节点组id',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '目标节点组id',
    prop: 'targetNodeGroupId',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入目标节点组id',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '转换点',
    prop: 'transformPoint',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入转换点',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '列策略',
    prop: 'columnPolicy',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入列策略',
      trigger: 'blur'
    }]
  },  {
    fixed: true,
    label: '源目录名称',
    prop: 'sourceCatalogName',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入源目录名称',
      trigger: 'blur'
    }]
  },  {
    fixed: true,
    label: '源库名称',
    prop: 'sourceSchemaName',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入源库名称',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '源表名称',
    prop: 'sourceTableName',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入源表名称',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '目标目录名称',
    prop: 'targetCatalogName',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入目标目录名称',
      trigger: 'blur'
    }]
  }, {
    fixed: true,
    label: '目标库名称',
    prop: 'targetSchemaName',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入目标库名称',
      trigger: 'blur'
    }]
  },{
    fixed: true,
    label: '目标表名称',
    prop: 'targetTableName',
    editDisabled: true,
    rules: [{
      required: true,
      message: '请输入目标表名称',
      trigger: 'blur'
    }]
  },{
    label: '部署时间',
    prop: 'deploymentTime',
    type: 'datetime',
    format: 'yyyy-MM-dd HH:mm',
    valueFormat: 'timestamp',
    editDisabled: true,
    addVisdiplay: false
  }]
}
