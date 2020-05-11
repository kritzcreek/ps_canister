import ps_canister from 'ic:canisters/ps_canister';

ps_canister.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
