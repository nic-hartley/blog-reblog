module BlogReblog.Core.Metadata(
    SiteSpec(linkToUuids), siteAt,
    FileSpec(title, shareOf, author, created, updated), post, page, asset, index
) where

import Crypto.Hash ( SHA3_256 (SHA3_256), hashWith )
import qualified Data.ByteArray as BA
import Data.Time (UTCTime)
import Data.UUID.Types (UUID, fromByteString)
import Data.Maybe (fromJust)
import Data.ByteString (ByteString, fromStrict)

{- |
Metadata describing the entire site as a whole.

Primarily, this is about 
-}
data SiteSpec = SiteSpecCtor {
    baseUrl :: String,
    linkToUuids :: Bool
}

siteAt :: String -> SiteSpec
siteAt baseUrl = SiteSpecCtor { baseUrl, linkToUuids = False }

{- |
Metadata describing a single file hosted by the site. There are lots of kinds
of files, but they all share the @id@ property, which is a UUID based on the
hash of the file's contents.
-}
data FileSpec =
    -- | A post on the blog section of the site.
    PostSpec {
        id :: UUID,
        title :: String,
        shareOf :: Maybe UUID,
        author :: Maybe String,
        created :: Maybe UTCTime,
        updated :: Maybe UTCTime
    } |
    -- | An arbitrary static page on the site.
    PageSpec {
        id :: UUID,
        title :: String,
        path :: String
    } |
    -- | A raw static asset to be served directly, with no processing.
    AssetSpec { path :: String } |
    -- | The site index, aka the homepage, hosted at the site root.
    IndexSpec

hashToUuid :: ByteString -> UUID
hashToUuid =
    let getBytes = BA.take 16 . BA.convert . hashWith SHA3_256
        toUuid = fromJust . fromByteString . fromStrict
    in  toUuid . getBytes
urlForTitle :: String -> String
urlForTitle =
    let dashify = spli
        lower = map toLower


post :: ByteString -> String -> FileSpec
post contents title = PostSpec {
    id = hashToUuid contents,
    title = title,
    shareOf = Nothing,
    author = Nothing,
    created = Nothing,
    updated = Nothing
}

page :: ByteString -> String -> FileSpec
page contents title = PageSpec {
    id = hashToUuid contents,
    title = title,
    path = urlForTitle title
}

asset :: String -> FileSpec
asset path = AssetSpec { path }

index :: FileSpec
index = IndexSpec
