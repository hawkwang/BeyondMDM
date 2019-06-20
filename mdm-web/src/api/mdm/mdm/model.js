/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/model/page',
    method: 'get',
    params: query
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/model/',
    method: 'post',
    data: obj
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/model/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/model/' + row.id ,
    method: 'delete'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/model/',
    method: 'put',
    data: obj
  })
}


