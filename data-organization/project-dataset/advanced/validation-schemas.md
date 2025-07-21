# JSON Schema Validation for Image Metadata

## Overview

**JSON Schema** Validation allows you to enforce a consistent structure for image metadata when uploading images to projects. By defining a **JSON schema** at the project level, you ensure that all uploaded metadata adheres to the required structure. If the metadata does not match the schema, the upload will be rejected with a clear validation error, preventing inconsistent or incomplete data from entering your project.

## Use Case Example

Imagine you're uploading images to a project where each image needs specific metadata:
- Camera settings (ISO, aperture, shutter speed)
- Location information (GPS coordinates, address)
- Quality metrics (brightness, contrast, sharpness)

Without validation, different team members might upload images with inconsistent metadata structure. With JSON schema validation, you ensure all metadata follows the same format.

## Setting Up Validation

### Step 1: Define Your Schema

Create a JSON schema that defines the required structure for your image metadata. For example:

```json
{
  "type": "object",
  "required": ["camera", "location", "quality"],
  "properties": {
    "camera": {
      "type": "object",
      "required": ["iso", "aperture"],
      "properties": {
        "iso": {"type": "number"},
        "aperture": {"type": "string"},
        "shutter_speed": {"type": "string"}
      }
    },
    "location": {
      "type": "object",
      "required": ["lat", "lng"],
      "properties": {
        "lat": {"type": "number"},
        "lng": {"type": "number"},
        "address": {"type": "string"}
      }
    },
    "quality": {
      "type": "object",
      "properties": {
        "brightness": {"type": "number"},
        "contrast": {"type": "number"}
      }
    }
  }
}
```

### Step 2: Set Schema for Project

Apply the schema to your project using the API:

```python
import supervisely as sly

api = sly.Api.from_env()
project_id = 12345

# Set validation schema for project
api.project.set_validation_schema(project_id, schema)

# Get current validation schema
current_schema = api.project.get_validation_schema(project_id)
```

### Step 3: Upload Images with Validation

When uploading images, enable validation to ensure metadata compliance:

```python
# Upload images with validation enabled
image_paths = ["/path/to/image1.jpg", "/path/to/image2.jpg"]
names = ["image1.jpg", "image2.jpg"]
metas = [
    {
        "camera": {"iso": 800, "aperture": "f/2.8"},
        "location": {"lat": 37.7749, "lng": -122.4194}
    },
    {
        "camera": {"iso": 400, "aperture": "f/1.8"},
        "location": {"lat": 40.7128, "lng": -74.0060}
    }
]

api.image.upload_paths(
    dataset_id=dataset_id,
    names=names,
    paths=image_paths,
    metas=metas,
    validate_meta=True,  # Enable validation
    use_strict_validation=False  # Optional: strict mode
)
``` Valid metadata example:

```json
{
  "camera": {
    "iso": 800,
    "aperture": "f/2.8",
    "shutter_speed": "1/60"
  },
  "location": {
    "lat": 37.7749,
    "lng": -122.4194,
    "address": "San Francisco, CA"
  },
  "quality": {
    "brightness": 0.7,
    "contrast": 0.8
  }
}
```

## Validation Options

### Standard Validation
```python
# Standard validation - allows extra fields
api.image.upload_paths(
    dataset_id=dataset_id,
    names=names,
    paths=image_paths,
    metas=metas,
    validate_meta=True,
    use_strict_validation=False  # Default Value
)
```

### Strict Validation
```python
# Strict validation - exact schema match required
api.image.upload_paths(
    dataset_id=dataset_id,
    names=names,
    paths=image_paths,
    metas=metas,
    validate_meta=True,
    use_strict_validation=True  # Set to True for strict validation
)
```

### Optimized Validation with Caching
```python
# Use caching for better performance with multiple uploads
api.image.upload_paths(
    dataset_id=dataset_id,
    names=names,
    paths=image_paths,
    metas=metas,
    validate_meta=True,
    use_caching_for_validation=True  # Schema cached for 1 hour
)
```

## Validating Existing Projects

For projects with existing images, you can validate all current data:

```python
# Validate all existing images in project
validation_result = api.project.validate_entities_schema(project_id)

# Check validation results
if not validation_result:
    print("All entities are valid according to the schema!")
else:
    print(f"Found {len(validation_result)} entities that don't match the schema:")
    
    for entity in validation_result:
        print(f"\nEntity: {entity['entity_name']} (ID: {entity['entity_id']})")
        
        if entity['missing_fields']:
            print(f"  Missing fields: {', '.join(entity['missing_fields'])}")
        
        if entity['extra_fields']:
            print(f"  Extra fields: {', '.join(entity['extra_fields'])}")
```

This process helps you:
- Identify non-compliant images in existing projects
- Get detailed error reports for each failed image
- Fix metadata issues before enforcing strict validation

## Benefits

- **Consistency**: All images have the same metadata structure
- **Quality Control**: Prevent incomplete or incorrect metadata uploads
- **Team Coordination**: Everyone follows the same metadata standards
- **Data Integrity**: Maintain clean, structured datasets
- **Error Prevention**: Catch metadata issues at upload time

## Common Schema Patterns

### Simple Required Fields
```json
{
  "type": "object",
  "required": ["timestamp", "source"],
  "properties": {
    "timestamp": {"type": "string"},
    "source": {"type": "string"}
  }
}
```

### Nested Structures
```json
{
  "type": "object",
  "required": ["equipment"],
  "properties": {
    "equipment": {
      "type": "object",
      "required": ["camera_model"],
      "properties": {
        "camera_model": {"type": "string"},
        "lens": {"type": "string"}
      }
    }
  }
}
```

### Optional Fields with Defaults
```json
{
  "type": "object",
  "required": ["image_id"],
  "properties": {
    "image_id": {"type": "string"},
    "quality_checked": {"type": "boolean", "default": false},
    "notes": {"type": "string"}
  }
}
```

## Complete Example

Here's a full workflow example:

```python
import supervisely as sly

# Initialize API
api = sly.Api.from_env()
project_id = 12345
dataset_id = 67890

# 1. Define schema
schema = {
    "type": "object",
    "required": ["camera", "location"],
    "properties": {
        "camera": {
            "type": "object",
            "required": ["iso", "aperture"],
            "properties": {
                "iso": {"type": "number"},
                "aperture": {"type": "string"}
            }
        },
        "location": {
            "type": "object",
            "required": ["lat", "lng"],
            "properties": {
                "lat": {"type": "number"},
                "lng": {"type": "number"}
            }
        }
    }
}

# 2. Set schema for project
api.project.set_validation_schema(project_id, schema)

# 3. Upload images with validation
image_paths = ["/path/to/image1.jpg"]
names = ["image1.jpg"]
metas = [{
    "camera": {"iso": 800, "aperture": "f/2.8"},
    "location": {"lat": 37.7749, "lng": -122.4194}
}]

try:
    api.image.upload_paths(
        dataset_id=dataset_id,
        names=names,
        paths=image_paths,
        metas=metas,
        validate_meta=True
    )
    print("Upload successful - metadata valid!")
except Exception as e:
    print(f"Upload failed: {e}")
```

## Best Practices

- **Start simple**: Begin with basic required fields, add complexity gradually
- **Document your schema**: Include field descriptions and examples
- **Test thoroughly**: Validate your schema with sample data before deployment
- **Version your schemas**: Track changes when updating validation rules
- **Communicate changes**: Inform team members about new validation requirements

## Requirements

- Supervisely instance version: 6.12.5 or later
- Supervisely Python SDK: 6.73.228 or later