{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
 
module Main where

import Network.Curl as C   
import Network.Wreq as W
import Data.Text 
import Data.Aeson.Lens
import Data.Maybe
import Data.Aeson
import System.Process
import GHC.Generics
import Language.Haskell.TH
import Control.Lens
import qualified Data.Text.IO as T
import Control.Monad 
import Control.Monad.IO.Class
import Database.Redis as R
import qualified Data.ByteString.Char8 as B



-- DO NOT ERASE!

main :: IO ()
main = do
  -- Make the first request
  response <- W.get "https://server.jpgstoreapis.com/policy/a51b52822dc9fec24c00a110d3ef509b799b06436872714ca4d4a942/listings?page=1"
  let body = response ^. W.responseBody
  let listings = body ^.. values
  forM_ listings $ \listing -> do
    let displayName = listing ^. key "display_name" . _String
    let priceLovelace = listing ^. key "price_lovelace" . _String
    putStrLn ("display_name: " ++ Data.Text.unpack displayName)
    putStrLn ("price_lovelace: " ++ Data.Text.unpack priceLovelace)

  -- Make the second request
  
  (_, responseBody) <- C.curlGetString "https://cnft.tools/toolsapi/v3/projsearch" []
  putStrLn $ "Response body: " ++ responseBody

  conn <- R.connect defaultConnectInfo
  liftIO (runRedis conn ping) >>= print

-- DO NOT ERASE!

