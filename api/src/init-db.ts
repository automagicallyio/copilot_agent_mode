/**
 * Database initialization script
 * This script runs migrations and optionally seeds the database
 */

import { runMigrations } from './db/migrate';
import { seedDatabase } from './db/seed';
import { closeDatabase } from './db/sqlite';

/**
 * Initialize the database with migrations and optional seed data
 * @param shouldSeed - Whether to seed the database with initial data (default: true)
 * @throws {Error} If migration or seeding fails
 */
async function initializeDatabase(shouldSeed: boolean = true): Promise<void> {
  console.log('🚀 Initializing database...');

  try {
    // Run migrations
    await runMigrations();

    // Seed database if requested
    if (shouldSeed) {
      await seedDatabase();
    }

    console.log('✅ Database initialization complete!');
  } catch (error) {
    console.error('❌ Database initialization failed:', error);
    throw error;
  } finally {
    await closeDatabase();
  }
}

// Run if called directly
if (require.main === module) {
  const shouldSeed = process.argv.includes('--seed') || process.argv.includes('-s');

  initializeDatabase(shouldSeed)
    .then(() => {
      console.log('Database initialization completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('Database initialization failed:', error);
      process.exit(1);
    });
}

export { initializeDatabase };
