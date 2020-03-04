function* makeNumber(num) {
  let count = num;
  while (true) {
    yield ++count;
  }
}

function hello(num) {
  return new Promise((resolve) => setTimeout(() => resolve(num * num), 1000));
}

(async () => {

  const factory = makeNumber(10);

  const result = await hello(factory.next().value);
  console.log(result);
})();

