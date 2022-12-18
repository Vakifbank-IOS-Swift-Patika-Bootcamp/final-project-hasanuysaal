# Game Book

- Game Book uygulaması rawg.io sitesinin sağlamış olduğu verileri kullanarak, oyunları listeleyen, detaylarını gösteren, listelenen oyunlar arasında arama, filtreleme ve sıralama yapılmasını sağlayan, oyunların favorilere eklenmesini ve oyunlar hakkında notlar tutulmasını sağlayan, Türkçe ve İngilizce olmak üzere 2 dil desteği bulunan bir API uygulamasıdır.

- Uygulama MVVM mimarisi kullanılarak yazılmıştır.
- Kütüphanelerin eklenmesi için SPM kullanılmışır.
* Kullanılan Kütüphaneler
* * [SDWebImage](https://github.com/SDWebImage/SDWebImage.git)
* * [Swift Alert View](https://github.com/dinhquan/SwiftAlertView.git)
* * [Material Activity Indıcator](https://github.com/nspavlo/MaterialActivityIndicator.git)
* Kullanılan API
* * [Rawg.io API](https://rawg.io/apidocs)

## Açılış Ekranı ve Bildirim İzni

- Uygulama açılışında basit bir launcscreen tasarlanmıştır ve ilk açılışta kullanıcıdan bildirimlerlere izin vermesi istenilmektedir. 

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208311454-d37ab19c-b8f2-4877-a375-dc6df30a5d94.gif" alt="drawing" width="275"/></td>  
</div>

## Dil Desteği ve Bildirim

- Uygulamanın sağ üst köşesinde bulunan butona tıklandığında uygulama kapanmaktadır. Uygulama kapandıktan sonra kullanıcıya uygulama dilinin değiştiğine dair bildirim gitmekte ve kullanıcı bu bildirime tıkladığında uygulama tekrar açılmaktadır.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208311669-eedb4726-0c9a-48af-be99-f29a4e87c1ea.gif" alt="drawing" width="275"/></td>  
</div>

## Oyun Arama

- Uygulamanın oyunlar listesi ekranınında bulunan arama barında girilen değere göre benzer oyunlar listelenmektedir.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208311753-56ac376d-9957-44bb-b5a1-8d7201af291b.gif" alt="drawing" width="275"/></td>  
</div>

## Sayfalar Arası Gezinme

- Oyunların listelendiği ekranın en altında önceki ve sonraki olmak üzere iki adet buton bulunmaktadır. Bu butonlara tıklandığında sayfalar arası geçiş sağlanmaktadır.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208311849-867d6628-f841-4169-b457-9c7785b188e4.gif" alt="drawing" width="275"/></td>  
</div>

## Filtreleme ve Sıralama

- Oyun listesi ekranında popüler oyunlar ve yakında gelecek oyunlar filtrelenebilirken, sıralama tuşu ile liste ekranındaki oyunlar puanlarına göre yüksekten düşeğe sıralanmaktadır.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208311963-52a62317-ffcd-43a2-95f5-cad451e35aa4.gif" alt="drawing" width="275"/></td>  
</div>

## Oyun Detayı

- Oyun listesi ekranından tıklanınlan oyunun detayları yeni bir ekranda açılmaktadır. Burada oyunun bulunduğu platformlar, ortalama oyun süresi, oyun açıklaması, oyun türü ve metascore puanı kullanıcıya gösterilmektedir.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208312047-3358fcce-cfab-4755-b0da-040c3fd3397f.gif" alt="drawing" width="275"/></td>  
</div>

## Favoriler

- Favoriler ekranında favoriye eklenen oyunlar listelenmektedir. Listeden oyuna tıklanıldığında oyun detayı açılmakatadır. Listeden oyunlar favori listesinden silinebilmektedir. Aynı zamanda oyun listesinden gidilen oyun detayında bulunan favori butonuna tekrar tıklandığında da oyun favori listesinden silinmektedir.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208312118-34c849b2-f89e-4f15-bded-1f889c2f17e5.gif" alt="drawing" width="275"/></td>  
</div>

## Notlar

- Bu ekranda kullanıcı oyunlar hakkında not ekleyebilmekte, listelenen notları güncelleyebilmekte ve silebilmektedir. Kullanıcıdan yeni not için resim, oyun adı ve not eklemesi istenmektedir. Girilmeyen bilgiler için uyarı verilmektedir. Oyun adı için metin alanına klavyeden veri girilmekte, girildikten sonra arama butonuna tıklanmakta sonrasında ise tekrar metin alanına dokunulduğunda girilen metine benzer oyunların isimleri listelenmekte ve kullanıcı bu isimlerden birini seçebilmektedir.

<div align="center">
<table>
<tr>
<td><img src="https://user-images.githubusercontent.com/52783499/208312274-d284a33c-3cf2-40c4-846a-185525968213.gif" alt="drawing" width="275"/></td>  
<td><img src="https://user-images.githubusercontent.com/52783499/208312307-29758ecf-3d53-4fae-a5d7-d99e9b6b834f.gif" alt="drawing" width="275"/></td>  
<td><img src="https://user-images.githubusercontent.com/52783499/208312324-230933dc-185b-4e41-9921-b50b4f1d248f.gif" alt="drawing" width="275"/></td>  
</td>  
</tr>
</table>
</div>

## Kaydetme

- Uygulamada veri saklamak için CoreData kullanılmıştır. Uygulama kapansa da favori listesi ve not listesi verileri hafızada tutulmakta ve silinmemektedir.

<div align="center">
<img src="https://user-images.githubusercontent.com/52783499/208312382-afe0f42c-7fe9-4a1f-a051-97518c42db99.gif" alt="drawing" width="275"/></td>  
</div>

## Tetsler

- Uygulamada yazılan tüm testler başarıyla çalışmıştır.

<img width="1224" alt="Ekran Resmi 2022-12-18 21 16 47" src="https://user-images.githubusercontent.com/52783499/208313011-ebcc67dc-9baf-4125-a991-abd9f868d72c.png">
<img width="1207" alt="Ekran Resmi 2022-12-18 21 17 56" src="https://user-images.githubusercontent.com/52783499/208313027-b5bd80bd-aa8e-44ad-bfee-67d08ac6d81c.png">

## Geliştirme Ortamı
- Xcode 13.4.1 
