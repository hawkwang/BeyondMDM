/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/view/page',
    method: 'get',
    params: query
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/view/',
    method: 'post',
    data: obj
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/view/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/view/' + row.id ,
    method: 'delete'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/view/',
    method: 'put',
    data: obj
  })
}


