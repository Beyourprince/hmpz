import { userInfo } from '../api/api'

@Component
struct my {
  changeOrderTab: (index: number, type: string) => void = () => {
  }
  @State userInfo: userInfo | undefined = {
    'avatar': 'http://159.75.169.224:5500/avatar.jpeg',
    "name": 'admin'
  }
  server_list: Record<string, string> = {
    "app.media.od_10": "待支付",
    "app.media.od_20": "待服务",
    "app.media.od_30": "已完成",
    "app.media.od_40": "已取消",
  }

  build() {
    Column() {
      Column() {
        Image(this.userInfo?.avatar).width(100)
        Text(this.userInfo?.name).fontWeight(FontWeight.Bold)
      }.width('100%')
      .height(200)
      .backgroundColor(Color.White)
      .justifyContent(FlexAlign.Center)

      Column() {
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text('我的订单')
          Text('全部').fontSize(13).fontColor('#999')
        }.border({ width: { bottom: 1 }, color: '#ffebedf0' })
        .padding(5)
        .onClick(() => {
          this.changeOrderTab(1, '全部')
        })

        Flex({ justifyContent: FlexAlign.SpaceAround }) {
          ForEach(Object.keys(this.server_list), (item: string) => {
            Column() {
              Image($r(item)).width(50)
              Text(this.server_list[item]).fontSize(13).fontColor('#999')
            }.onClick(() => {

              this.changeOrderTab(1, this.server_list[item])
            })
          })
        }.margin(5)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(5)
      .margin({ top: 10 })
      .padding(10)

      Column() {
        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text('服务对象管理').lineHeight(20)
          Text('>')
        }.border({ width: { bottom: 1 }, color: '#ffebedf0' })
        .padding(5)

        Flex({ justifyContent: FlexAlign.SpaceBetween }) {
          Text('分享转发').lineHeight(20)
          Text('>')
        }.padding(5)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(5)
      .margin({ top: 10 })
      .padding(10)

      Button('退出登录', { type: ButtonType.Normal })
        .borderRadius(2)
        .width('90%')
        .backgroundColor(Color.Red)
        .margin({ top: 10 })
        .onClick(() => {
        })

    }.backgroundColor('#f0f0f0')
    .height('100%')
    .padding(10)
  }
}

export default my