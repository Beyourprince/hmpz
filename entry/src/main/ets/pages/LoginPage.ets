import { login } from '../api/api'

@Entry
@Component
struct LoginPage {
  onPageShow(): void {
    console.info('pageshow')
    login({
      userName: '13184226481',
      passWord: '123456'
    }).then((res) => {
      console.log('+++res', JSON.stringify(res))
    })
  }

  build() {

  }
}