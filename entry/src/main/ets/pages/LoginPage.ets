import { login, login_type } from '../api/api'
import { router } from '@kit.ArkUI'
import preferences from '../utils/preferences'

@Entry
@Component
struct LoginPage {
  @State @Watch('changData') formData: login_type = {
    userName: "",
    passWord: ""
  }
  @State isRuleTip: boolean = false

  changData() {
    this.isRuleTip = false
  }

  // onPageShow(): void {
  //   console.info('pageshow')
  //   login({
  //     userName: '13184226481',
  //     passWord: '123456'
  //   }).then((res) => {
  //     console.log('+++res', JSON.stringify(res))
  //   })
  // }

  build() {
    Column() {
      Text('用户登录').width('100%').fontSize(20)
        .fontWeight(FontWeight.Bold)
        .textAlign(TextAlign.Center)
      Row() {
        Text('用户名').width('20%')
        TextInput({ placeholder: '请输入用户名', text: this.formData.userName })
          .onChange(value => {
            this.formData.userName = value
          }).width('70%')
          .borderRadius(0).backgroundColor(Color.White)
      }

      Row() {
        Text('密码').width('20%')
        TextInput({ placeholder: '请输入密码', text: this.formData.passWord })
          .onChange(value => {
            this.formData.passWord = value
          }).width('70%')
          .borderRadius(0).backgroundColor(Color.White)
      }

      if (this.isRuleTip) {
        Text('请把用户名和密码都填写上！').fontColor(Color.Red)
      }
      Button('提交').width('80%').margin({ top: 20 })
        .onClick(() => {
          if (!this.formData.userName && !this.formData.passWord) {
            this.isRuleTip = true
          }
          login(this.formData).then(async (data) => {
            await preferences.set('token', data.token)
            await preferences.set('userInfo', JSON.stringify(data.userInfo))
            router.pushUrl({ url: 'pages/Index' })
          })
          console.log('prefereneces', preferences.get('token', ''))

        })
    }
  }
}