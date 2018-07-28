# XZKit/CollectionViewFlowLayout

## 安装

```ruby
pod "XZKit/CollectionViewFlowLayout"
```

## 特性

- 支持设置垂直、水平对齐方式。
- 支持垂直、水平两种滚动方向。
- 自适应布局方向，如阿拉伯语环境下自右向左布局。
- 支持 Objective-C 与 Swift 。

## 效果

<video id="video" controls="" preload="none">
    <source id="mp4" src="./CollectionViewFlowLayout.mp4" type="video/mp4">
    <p>Your user agent does not support the HTML5 Video element.</p>
</video>

## 示例

与 [UICollectionViewFlowLayout](https://developer.apple.com/documentation/uikit/uicollectionviewflowlayout) 完全相同的用法，只是额外增加了两个属性来设置对齐方式。

```swift
let flowLayout = CollectionViewFlowLayout.init()
/// 滚动方向。默认 .vertical 。
flowLayout.scrollDirection = .vertical
/// 行间距。滚动方向为垂直时，水平方向为一行；滚动方向为水平时，垂直方向为一行。默认 0 ，代理方法的返回值优先。
flowLayout.minimumLineSpacing = 10
/// 内间距。同一行内两个元素之间的距离。默认 0 ，代理方法的返回值优先。
flowLayout.minimumInteritemSpacing = 10
/// 元素大小。默认 (50, 50)，代理方法返回的大小优先。
flowLayout.itemSize = CGSize.init(width: 50, height: 50)
/// SectionHeader 大小，默认 0 ，代理方法的返回值优先。
flowLayout.headerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 30)
/// SectionFooter 大小，默认 0 ，代理方法的返回值优先。
flowLayout.footerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 30)
/// SectionItem 外边距。不包括 SectionHeader/SectionFooter 。默认 .zero ，代理方法的返回值优先。
flowLayout.sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
/// 行对齐方式，默认 .leading ，代理方法的返回值优先。
flowLayout.lineAlignment = .justified
/// 元素对齐方式，默认 .median ，代理方法的返回值优先。
flowLayout.interitemAlignment = .median

let collectionView = UICollectionView.init(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
```

通过 `CollectionViewDelegateFlowLayout` 协议，你甚至可以自定义每一个元素的对齐方式。

```swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, lineAlignmentForSectionAt section: Int, forLine line: Int) -> CollectionViewFlowLayout.LineAlignment {
    if line % 2 == 0 {
        return .trailing
    }
    return .leading
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, interitemAlignmentForSectionAt section: Int, forItemInLineAt indexPath: IndexPath) -> CollectionViewFlowLayout.InteritemAlignment {
    if indexPath.line % 2 == 0 {
        return .top
    }
    return .bottom
}
```


