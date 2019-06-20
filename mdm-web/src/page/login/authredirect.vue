<template>
  <div></div>
</template>

<script>
import request from '@/router/axios'
import { mapGetters } from 'vuex'
export default {
  name: 'authredirect',
  computed: {
    ...mapGetters(['tagWel'])
  },
  created () {
    const params = this.$route.query
    const state = params.state
    const code = params.code
    const type = params.type

    if (type === 'BIND') {
      request({
        url: '/admin/social/bind',
        method: 'post',
        params: { state, code }
      }).then(() => {
        this.$alert('社交账号绑定成功', '成功', {
          confirmButtonText: '确定',
          callback: action => {
            window.close()
          }
        })
      })
    } else {
      window.close()
      window.opener.location.href = `${window.location.origin}/#/login?state=${state}&code=${code}&time=`+new Date().getTime()
    }
  }
}
</script>


<style>
</style>
