// GENESIS OS Core Structure
CREATE (genesis:Project {
  id: 'genesis_os', 
  name: 'Genesis OS', 
  version: '1.0.0',
  description: 'Autonomous Neuro-Adaptive Operating System'
});

// Modules
CREATE (neuroweb:Module {id: 'neuroweb', name: 'NeuroWeb Overlay', status: 'active'});
CREATE (kernel:Module {id: 'kernel', name: 'NeuroKernel', status: 'development'});

// Relationships
MATCH (g:Project {id: 'genesis_os'})
MATCH (n:Module {id: 'neuroweb'})
MATCH (k:Module {id: 'kernel'})
MERGE (g)-[:HAS_MODULE]->(n)
MERGE (g)-[:HAS_MODULE]->(k);

// Initial Tasks
CREATE (task1:Task {
  id: 'task001',
  title: 'Implement BCI interface',
  priority: 'high',
  status: 'pending'
});
