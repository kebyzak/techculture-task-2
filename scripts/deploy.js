const hre = require("hardhat");

async function main() {
  const KazybekToken = await hre.ethers.getContractFactory("KazybekToken");
  const kazybekToken = await KazybekToken.deploy();
  await kazybekToken.deployed();

  console.log("Kazybek Token:", kazybekToken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
