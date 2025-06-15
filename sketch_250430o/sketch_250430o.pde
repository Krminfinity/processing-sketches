// FLUID SIMULATION EXAMPLE
// Based on PixelFlow's Getting Started example:
// https://github.com/diwi/PixelFlow#getting-started---fluid-simulation

import com.thomasdiewald.pixelflow.java.DwPixelFlow;
import com.thomasdiewald.pixelflow.java.fluid.DwFluid2D;

// fluid simulation
DwFluid2D fluid;

// render target for fluid
PGraphics pg_fluid; // Changed from PGraphics2D to PGraphics for broader compatibility

public void setup() {
  size(800, 800, P2D); // Using P2D renderer

  // library context
  DwPixelFlow context = new DwPixelFlow(this);
  context.print(); // Print library info

  // fluid simulation object
  // DwFluid2D(DwPixelFlow context, int ResX, int ResY, int SuperSamples)
  // lower ResX/ResY for better performance if needed
  // SuperSamples: 1 means no supersampling, >1 enables it (e.g., 2 for 2x2 grid per cell)
  fluid = new DwFluid2D(context, width, height, 1);

  // Set some fluid parameters (can be tweaked)
  fluid.param.dissipation_velocity = 0.70f; // How quickly velocity fades
  fluid.param.dissipation_density  = 0.99f; // How quickly density fades
  fluid.param.dissipation_pressure = 0.80f; // Pressure dissipation
  fluid.param.vorticity     = 0.10f; // Adds curling motion to the fluid

  // Callback for adding data to the fluid simulation (e.g., mouse interaction)
  fluid.addCallback_FluiData(new DwFluid2D.FluidData() {
    public void update(DwFluid2D fluid) {
      if (mousePressed) {
        // Mouse coordinates, flipping Y for fluid simulation space
        float px = mouseX;
        float py = height - mouseY;

        // Velocity based on mouse movement
        float vx = (mouseX - pmouseX) * +15;
        float vy = (mouseY - pmouseY) * -15; // Y-velocity needs to be flipped too

        // Add velocity and density at mouse position
        // addVelocity(float x, float y, float radius, float val_x, float val_y)
        fluid.addVelocity(px, py, 14, vx, vy);

        // addDensity(float x, float y, float radius, float r, float g, float b, float a)
        // Adding two colors for visual effect
        fluid.addDensity (px, py, 20, 0.0f, 0.4f, 1.0f, 1.0f); // Blueish
        fluid.addDensity (px, py, 8,  1.0f, 1.0f, 1.0f, 1.0f); // White
      }
    }
  });

  // Create a PGraphics for rendering the fluid, matching main sketch size and renderer
  pg_fluid = createGraphics(width, height, P2D);
  pg_fluid.smooth(4); // Enable anti-aliasing on the PGraphics if desired

  println("PixelFlow Fluid Simulation Example Initialized.");
  println("Drag mouse to interact with the fluid.");
}


public void draw() {
  // Update the fluid simulation
  fluid.update();

  // Render the fluid simulation to the PGraphics object
  // fluid.renderFluidTextures(PGraphics dst, int mode)
  // mode 0: Density
  // mode 1: Velocity
  // mode 2: Pressure
  // mode 3: Temperature
  // mode 4: Divergence
  // mode 5: Vorticity
  // mode 6: Obstacles
  // mode 7: Velocity (color coded)

  pg_fluid.beginDraw();
  pg_fluid.background(0,0,0,0); // Clear with transparent background
  fluid.renderFluidTextures(pg_fluid, 0); // Render density to our PGraphics
  pg_fluid.endDraw();

  // Display the PGraphics content to the main sketch window
  background(0); // Clear main window to black
  image(pg_fluid, 0, 0);
}
