import request from '@/router/axios'

export function GetMenu () {
  return request({
    url: '/admin/menu',
    method: 'get'
  })
}

export function fetchMenuTree (query) {
  return request({
    url: '/mdm/api/enginelist',
    method: 'get',
    params: query
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/api/engine/confInstall?externalId='+obj.externalId+"&nodeGroupId="+obj.nodeGroupId
    +'&databaseDriver='+obj.databaseDriver+'&databaseUrl='+obj.databaseUrl+'&dbPassword='+obj.dbPassword
    +'&dbUser='+obj.dbUser,
    method: 'post'
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/api/engine/' + id + '/status',
    method: 'get'
  })
}

export function delObj (id) {
  console.log(id)
  return request({
    url: '/mdm/api/engine/'+id+'/uninstall',
    method: 'post'
  })
}

export function putObj (obj) {
  return request({
    url: '/admin/menu',
    method: 'put',
    data: obj
  })
}
