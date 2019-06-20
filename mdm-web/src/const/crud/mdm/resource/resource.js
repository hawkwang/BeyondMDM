/**
 * 资源管理
 */
export let tableOption = {
  border: true,
  searchShow:false,
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
    label: '实体',
    prop: 'modelId',
    type: 'tree',
    searchClearable: false,
    expandAll: true,
    dicUrl: '/mdm/entity/meTree',
    search: true
  }
  ]
}
export let option = {
  size:'',
  submitText: '选择',
  column: [
    {
      label: '选择模型',
      prop: 'modelId',
      type: 'select',
      props: {
        label: 'name',
        value: 'code'
      },
      cascaderItem: ['entity'],
      cascaderChange: true,
      dicUrl: `/mdm/model/unionDict`,
      rules: [
        {
          required: true,
          message: '请选择模型',
          trigger: 'blur'
        }
      ]
    },
    {
      label: '实体',
      prop: 'entity',
      type: 'select',
      props: {
        label: 'name',
        value: 'code'
      },
      dicFlag: false,
      dicUrl: `/mdm/entity/unionDict/{{key}}`,
      rules: [
        {
          required: true,
          message: '请选择实体',
          trigger: 'blur'
        }
      ]
    }
  ]
}
