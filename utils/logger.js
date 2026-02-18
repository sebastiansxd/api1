const fmt = (level, ...args) => {
  const ts = new Date().toISOString();
  console.log(`[${level}] ${ts} -`, ...args);
};

module.exports = {
  info: (...args) => fmt('INFO', ...args),
  error: (...args) => fmt('ERROR', ...args),
  debug: (...args) => fmt('DEBUG', ...args)
};
