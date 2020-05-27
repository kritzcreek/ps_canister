module Main where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Data.Maybe (Maybe(..))
import Effect.Aff (launchAff_)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)


type Canister = {
  greet :: String -> Promise String
}

main :: EffectFn1 Canister Unit
main = mkEffectFn1 \canister -> launchAff_ do
  let greet msg = Promise.toAff (canister.greet msg)
  response <- greet "Languages Team"
  body <- HA.awaitBody
  runUI (component response) unit body

type State = { enabled :: Boolean }

data Action = Toggle

component :: forall q i o m. String -> H.Component HH.HTML q i o m
component greeting =
  H.mkComponent
    { initialState
    , render: render greeting
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

initialState :: forall i. i -> State
initialState _ = { enabled: false }

render :: forall m. String -> State -> H.ComponentHTML Action () m
render greeting state =
  let
    label = if state.enabled then "up?" else "What's"
  in
  HH.div
    [ HP.classes
        [ H.ClassName "nes-container"
        , H.ClassName "with-title"
        , H.ClassName "is-centered"
        , H.ClassName "main"
        ]
    ]
    [ HH.p [ HP.class_ (H.ClassName "title")] [ HH.text greeting]
    , HH.button
        [ HP.title label
        , HE.onClick \_ -> Just Toggle
        , HP.class_ (H.ClassName "nes-btn")
        ]
        [ HH.text label ]
    ]

handleAction ∷ forall m o. Action → H.HalogenM State Action () o m Unit
handleAction = case _ of
  Toggle ->
    H.modify_ \st -> st { enabled = not st.enabled }
