import { it } from '@ohos/hypium'
import { getHomeData, return_home_type, slides, nav2s, hospitals } from '../api/api'
import { router } from '@kit.ArkUI'

@Component
struct home {
  @State homeData: return_home_type | null = null

  aboutToAppear(): void {
    getHomeData().then(res => {
      this.homeData = res
    })
  }

  build() {
    Scroll() {
      Column() {
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Text('中部地区>').fontSize(20).fontWeight(FontWeight.Bold)
            .fontColor(0x666666)
          Search({
            placeholder: '找医院'
          }).width('60%')
        }.padding({ left: 10, right: 10 })

        Swiper() {
          ForEach(this.homeData?.slides, (item: slides) => {
            Image(item.pic_image_url)
              .width("100%").padding(5).borderRadius(5)
          })
        }.autoPlay(true) /*自动播放*/
        .loop(true) /*循环播放默认开启*/

        Flex() {
          ForEach(this.homeData?.nav2s, (item: nav2s) => {
            Image(item.pic_image_url)
              .margin({ left: 5, right: 5 })
          })
        }

        ForEach(this.homeData?.hospitals, (item: hospitals) => {
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            Image(item.avatar_url).width('35%').borderRadius(5)
            Column() {
              Text(item.name).fontSize(20).fontWeight(FontWeight.Bold)
              Row() {
                Text(item.rank).margin({ right: 5 }).fontColor('#0ca7ae').fontWeight(FontWeight.Bold)
                Text(item.label).fontColor('#0ca7ae').fontWeight(FontWeight.Bold)
              }

              Text(item.intro).fontSize(13).fontColor("#999").lineHeight(15)
            }.alignItems(HorizontalAlign.Start).width('65%').margin({ left: 10 })
          }.margin(5)
          .borderRadius(3)
          .shadow({
            offsetX: 0,
            offsetY: 1,
            radius: 6,
            color: "#66000000"
          })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/createOrder',
              params:{
                id:item.id
              }
            })
          })
        })

      }.alignItems(HorizontalAlign.Start)
    }
  }
}

export default home
