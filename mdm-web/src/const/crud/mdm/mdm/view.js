
const DIC = {
  vaild: [{
    label: '否',
    value: '0'
  }, {
    label: '是',
    value: '1'
  }]
}

export const tableOption = {
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  refreshBtn: false,
  showClomnuBtn: false,
  searchSize: 'mini',
  viewBtn: true,
  editBtn: false,
  delBtn: false,
  column: [{
    width: 150,
    label: '名称',
    prop: 'name',
    rules: [{
      required: true,
      message: '请输入名称',
      trigger: 'blur'
    }]
  },{
    label: '所属实体',
    prop: 'entityId',
    type: 'tree',
    searchClearable:false,
    editDisabled: true,
    dicUrl: '/mdm/entity/meTree',
    search: true
  }, {
    label: '是否包含被删除成员',
    prop: 'includeDelete',
    type: 'radio',
    hide:true,
    dicData: DIC.vaild,
    rules: [{
      required: true,
      message: '是否包含被删除成员',
      trigger: 'blur'
    }]
  },{
    label: '创建id',
    prop: 'createId',
    editDisabled: true,
    addVisdiplay:false
  }, {
    label: '创建时间',
    prop: 'createTime',
    type: 'datetime',
    valueFormat:'timestamp',
    format: 'yyyy-MM-dd HH:mm',
    editDisabled: true,
    addVisdiplay:false
  },{
    label: '更新者id',
    prop: 'updateId',
    editDisabled: true,
    addVisdiplay:false
  }, {
    label: '更新时间',
    prop: 'updateTime',
    type: 'datetime',
    valueFormat:'timestamp',
    format: 'yyyy-MM-dd HH:mm',
    editDisabled: true,
    addVisdiplay:false
  }]
}
