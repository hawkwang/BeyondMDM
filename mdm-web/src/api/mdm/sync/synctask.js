/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/api/engine/jobs',
    method: 'get',
    params: query
  })
}

export function startJob(obj){
  return request({
    url: '/mdm/api/engine/startjob?jobName='+obj.jobName,
    method: 'post'
  })
}
export function stopJob(row) {
  return request({
    url: '/mdm/api/engine/stopjob?jobName='+row.jobName,
    method: 'post'
  })
}
export function addObj (obj) {
  console.log(obj)
  return request({
    url: '/mdm/api/engine/savejob?jobName='+obj.jobName+'&description='+obj.description+'&jobType='+obj.jobType+'&nodeGroupId='+obj.nodeGroupId+'&automaticStartup='+obj.automaticStartup+'&schedule='+obj.schedule+'&jobExpression='+obj.jobExpression,
    method: 'post'
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/attribute/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/attribute/' + row.id ,
    method: 'delete'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/attribute/',
    method: 'put',
    data: obj
  })
}


