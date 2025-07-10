#!/bin/bash
# Initialize GENESIS OS Knowledge Base

# Create Neo4j database
docker-compose -f docker-compose.gh200.yml up -d neo4j-gh200
sleep 30  # Wait for startup

# Load initial knowledge graph
docker exec -i neo4j-gh200 cypher-shell -u neo4j -p $NEO4J_PASSWORD < knowledge_graph/init_genesis.cypher

# Initialize agents
nemo-agent init \
  --config agent-configs/core-team.yaml \
  --knowledge-base neo4j://localhost:7687 \
  --output-dir /opt/neurogenesis/agents
